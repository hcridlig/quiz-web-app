const http = require('http');
const app = require('./app');
const { Server } = require('socket.io');
const apiUrl = 'http://localhost:4000';

const server = http.createServer(app);

let rooms = {};
var correctAnswer = '';

const io = new Server(server, {
    cors: {
        origin: "http://localhost:3000",
        methods: ["GET", "POST"],
    },
});

io.on('connection', (socket) => {
    console.log('a user connected', socket.id);

    socket.on('joinRoom', ({ roomId, roomName, playerName }) => {
        socket.join(roomId);
    
        if (!rooms[roomId]) {
            rooms[roomId] = { roomName: roomName, players: [] };
        }
    
        // Check if the player with the same name is already in the room before adding them
        const existingPlayerIndex = rooms[roomId].players.findIndex(player => player.name === playerName);
        if (existingPlayerIndex === -1) {
            rooms[roomId].players.push({ id: socket.id, name: playerName, score: 0 });
            console.log('rooms', rooms);
    
            // Emit only when a new player joins, not every time
            io.to(roomId).emit('playersInRoom', rooms[roomId].players);
            io.to(roomId).emit('roomName', rooms[roomId].roomName);
        }
    });
    
    socket.on('startGame', (roomId, idcat) => {
        console.log('startGame', roomId, idcat);
        io.to(roomId).emit('startGame');
        
        // Add request to create a game in the database
        fetch(`${apiUrl}/games/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                start_time: new Date(), // Set the start time to the current date and time
                idcat: idcat,
                roomid: roomId
            })
        })
        .then((response) => response.json())
        .then((data) => {
            console.log('Game created:', data); // Log the response from the server
        })
        .catch((error) => console.error('Error creating game:', error));
        
        try {
            fetch(`${apiUrl}/questions/${idcat}`)
                .then((response) => response.json())
                .then((data) => {
                    let questionIndex = 0;
                    const intervalId = setInterval(() => {
                        if (questionIndex < data.length) {
                            correctAnswer = data[questionIndex].correct_answer;
                            io.to(roomId).emit('game', data[questionIndex]); // Send the 'game' event to all clients in the room, excluding the sender
                            socket.emit('game', data[questionIndex]); // Send the 'game' event to the sender (room creator/host)
                            questionIndex++;
                        } else {
                            clearInterval(intervalId);
                            
                            // Add request to update the end time in the database
                            fetch(`${apiUrl}/games/update/${roomId}`, {
                                method: 'PUT',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify({
                                    end_time: new Date() // Set the end time to the current date and time
                                })
                            })
                            .then(() => {
                                console.log('End time updated successfully.'); // Log success message
                            })
                            .catch((error) => console.error('Error updating end time:', error));
    
                            socket.emit('end'); // Send the 'end' event to the sender (room creator/host)
                            io.to(roomId).emit('end'); // Send the 'end' event to all clients in the room when all questions have been sent
                        }
                    }, 1000); // Emit a new question every 10 seconds
                    
                    // Emit the first question immediately
                    if (data.length > 0) {
                        correctAnswer = data[questionIndex].correct_answer;
                        io.to(roomId).emit('game', data[questionIndex]);
                        socket.emit('game', data[questionIndex]);
                        questionIndex++;
                    }
                })
                .catch((error) => console.error('Error fetching data:', error));
        } catch (error) {
            console.error('Error fetching data:', error);
        }
    });
    
    

    socket.on('getGameResult', (idgame, playerId, roomId, playerName) => {
        const ranking = calculateGameResult(roomId);
        console.log('getGameResult', ranking);
        socket.emit('result', ranking );
        
        const score = ranking.ranking.find(player => player.name === playerName).score;
        console.log('score', score);
        console.log('idgame', idgame);
        console.log('playerId', playerId);
        
        // Add request to update the player's score in the database
        fetch(`${apiUrl}/results`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                idgame: idgame,
                iduser: playerId,
                score: score
            })
        })
        .then((response) => response.json())
        .then((data) => {
            console.log('Score updated:', data); // Log the response from the server
        })
        .catch((error) => console.error('Error updating score:', error));
    });
    
    function calculateGameResult(roomId) {
        const players = rooms[roomId].players;
        const sortedPlayers = players.sort((a, b) => b.score - a.score); // Sort players by score in descending order
        return { ranking: sortedPlayers }; // Send sorted players array along with the total number of players
    }

    socket.on('nextQuestion', (roomId) => {
        console.log('nextQuestion', roomId);
        if (rooms[roomId] && rooms[roomId].questions) {
            const question = rooms[roomId].questions.pop();
            io.to(roomId).emit('game', question);
        }
    });

    socket.on('answer', (roomId, playerName, selectedAnswer) => {        
        // Check if the player's answer matches the correct answer
        const playerIndex = rooms[roomId].players.findIndex(player => player.name === playerName);
        var score = rooms[roomId].players[playerIndex].score;
        if (selectedAnswer === correctAnswer) {
            // Update player's score
            if (playerIndex !== -1) {
                score += 1; // Increase player's score for a correct answer
                rooms[roomId].players[playerIndex].score = score;
            }
        }
        socket.emit('answerResult', { score, selectedAnswer, correctAnswer });
    });


    socket.on('disconnect', () => {
        console.log('User disconnected', socket.id);
    
        Object.keys(rooms).forEach((roomId) => {
            rooms[roomId].players = rooms[roomId].players.filter((player) => player.id !== socket.id);
            io.to(roomId).emit('playersInRoom', rooms[roomId].players);
        });
    });
    
});

module.exports = server;
