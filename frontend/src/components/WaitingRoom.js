import React, { useEffect, useState } from 'react';
import io from 'socket.io-client';
import { useLocation, useNavigate, useParams } from 'react-router-dom';
import { Button } from '@mui/material';

const WaitingRoom = () => {
    const apiUrl = process.env.REACT_APP_API_URL;
    const navigate = useNavigate();
    const location = useLocation();
    const [players, setPlayers] = useState([]);
    const [totalPlayers, setTotalPlayers] = useState(0);
    const socket = io(process.env.REACT_APP_SOCKET);
    window.socket = socket;
    const { roomId } = useParams();
    const [category, setCategory] = useState(location.state ? location.state.category : 'Default Category');
    var idCat = location.state ? location.state.idcat : 0;
    const token = document.cookie.split('; ').find(row => row.startsWith('token=')).split('=')[1];

    useEffect(() => {
        console.log('socket', socket);
        const playerName = localStorage.getItem('playerName');
        socket.emit('joinRoom', { roomId: roomId, roomName: category, playerName: playerName, idCat: idCat});
            
        socket.on('playersInRoom', updatedPlayers => {
            setPlayers(updatedPlayers);
            setTotalPlayers(updatedPlayers.length);
        });
        
        socket.on('roomName', (data) => {
            setCategory(data.roomName);
            idCat = data.idCat;
        });

        socket.on('startGame', () => {
            navigate('/game' , { state: { roomId: roomId } });
        });

        return () => {
            socket.off('playersInRoom');
            socket.off('roomName');
            socket.off('startGame');
        };

    }, [roomId, category]); // Added roomId and category to dependency array

    const handleStartGame = () => {
        socket.emit('startGame', roomId, idCat);
        //navigate('/game', { state: { category: category } });
    };

    return (
        <div style={{marginTop: '100px'}}>
            <h1>Waiting Room</h1>
            <p>Category: {category}</p>
            {totalPlayers < 2 ? (
                <div>
                    <p>Waiting for other players to join ...</p>
                    <ul>
                        {players.map((player, index) => (
                            <li key={index}>{player.name}</li>
                        ))}
                    </ul>
                </div>
            ) : (
                <div>
                    <p>Total players in the room: {totalPlayers}</p>
                    <ul>
                        {players.map((player, index) => (
                            <li key={index}>{player.name}</li>
                        ))}
                    </ul>
                    <ul>
                        <Button variant="contained" onClick={handleStartGame}>Start Game</Button>
                    </ul>
                </div>
            )}
        </div>

    );
};

export default WaitingRoom;
