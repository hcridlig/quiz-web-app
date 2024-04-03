const http = require('http');
const app = require('./app');
const { Server } = require('socket.io');

const server = http.createServer(app);

let rooms = {};

const io = new Server(server, {
    cors: {
        origin: "http://localhost:3000",
        methods: ["GET", "POST"],
    },
});

io.on('connection', (socket) => {
    console.log('a user connected', socket.id);

    socket.on('joinRoom', ({ roomName, playerName }) => {
        socket.join(roomName);

        if (!rooms[roomName]) {
            rooms[roomName] = [];
        }
        rooms[roomName].push({ id: socket.id, name: playerName });
        console.log('rooms', rooms);
        io.to(roomName).emit('playersInRoom', rooms[roomName]);
    });

    socket.on('disconnect', () => {
        console.log('User disconnected', socket.id);

        Object.keys(rooms).forEach((roomName) => {
            rooms[roomName] = rooms[roomName].filter((player) => player.id !== socket.id);
            io.to(roomName).emit('playersInRoom', rooms[roomName]);
        });
    });
});

module.exports = server;
