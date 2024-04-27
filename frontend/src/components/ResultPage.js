import React, { useEffect, useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { Typography, Button } from '@mui/material';
import { socket } from 'socket.io-client'; // Assuming you have a socket instance exported from a separate file

const ResultPage = () => {
    const apiUrl = process.env.REACT_APP_API_URL;
    const socket = window.socket;
    const location = useLocation();
    const roomId = location.state.roomId;
    const playerId = localStorage.getItem('playerId');
    const playerName = localStorage.getItem('playerName');
    const navigate = useNavigate();
    const [result, setResult] = useState(null);

    useEffect(() => {
        // Listen for result event from the server
        socket.on('result', (resultData) => {
            console.log('Result:', resultData);
            setResult(resultData);
        });
        
        
        const fetchIdGames = async () => {
            try {
                const response = await fetch(`${apiUrl}/games/${roomId}`);
                if (!response.ok) {
                    throw new Error('Failed to fetch data');
                }
                const responseData = await response.json(); // Parse JSON response
                
                // Extract idgame from the response data
                const { idgame } = responseData;
                socket.emit('getGameResult', idgame, playerId, roomId, playerName); // Request game result from the server
                
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        }; 
        
        fetchIdGames();
        // Clean up socket event listener on unmount
        return () => {
            socket.off('result');
        };
    }, []);

    const handleMenu = () => {
        // Redirect to the game page or any other page you want
        navigate('/');
    };

    return (
        <div style={{ textAlign: 'center', marginTop: '100px' }}>
            <Typography variant="h4" gutterBottom>
                Résulats du jeu
            </Typography>
            {result ? (
                <>
                    {result.ranking.map((player, index) => (
                        <Typography key={index} variant="body1" gutterBottom>
                            {index + 1}. {player.name} - Score: {player.score}
                            {index === 0 && ' 🏆 '} {/* Highlight the winner */}
                        </Typography>
                    ))}
                </>
            ) : (
                <Typography variant="body1" gutterBottom>
                    Waiting for game result...
                </Typography>
            )}
            <Button variant="contained" color="primary" onClick={handleMenu} style={{ marginTop: '20px' }}>
                Menu
            </Button>
        </div>
    );
};

export default ResultPage;
