import React, { useEffect, useState } from 'react';
import {
  Container,
  Typography,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
} from '@mui/material';

const GameHistory = ({ playerId }) => {
  const [gameHistoryData, setGameHistoryData] = useState([]);
  const [gamesInfo, setGamesInfo] = useState({});
  const apiUrl = process.env.REACT_APP_API_URL;

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Récupérer uniquement les résultats du joueur connecté
        const resultsResponse = await fetch(`${apiUrl}/results/user=${playerId}`);
        const results = await resultsResponse.json();

        // Récupérer les ID des parties du joueur connecté
        const gameIds = new Set(results.map((result) => result.games.idgame));

        // Récupérer les parties du joueur connecté
        const gamePromises = Array.from(gameIds).map((id) => fetch(`${apiUrl}/games/${id}`));
        const gameResponses = await Promise.all(gamePromises);
        const games = gameResponses.map((response) => response.json());
        const gamesData = await Promise.all(games);

        // Créer un objet pour stocker les informations sur les jeux en utilisant l'id comme clé
        const gamesInfoObj = {};
        gamesData.forEach((game) => {
          gamesInfoObj[game.idgame] = {
            date: game.start_time.split('T')[0], // Utiliser la date de début du jeu
            category: game.categories.title, // Utiliser le titre de la catégorie associée au jeu
          };
        });
        setGamesInfo(gamesInfoObj);

        // Transformer les données pour qu'elles correspondent à la structure utilisée dans le tableau d'historique des parties
        const transformedData = results.map((result) => {
          const gameInfo = gamesInfoObj[result.games.idgame];
          const numPlayers = Object.keys(results).filter((key) => results[key].games.idgame === result.games.idgame).length;
          const playerPosition = Object.keys(results)
            .filter((key) => results[key].games.idgame === result.games.idgame)
            .sort((a, b) => results[b].score - results[a].score)
            .indexOf(result.idresult) + 1;

          return {
            id: result.idresult,
            date: gameInfo.date,
            category: gameInfo.category,
            numPlayers,
            playerPosition,
            playerScore: result.score,
          };
        });

        // Trier le tableau en fonction de la date (du plus récent au plus ancien)
        transformedData.sort((a, b) => new Date(b.date) - new Date(a.date));

        setGameHistoryData(transformedData);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, [playerId]);

  return (
    <Container maxWidth="md" sx={{ mt: 17 }}>
      <Typography variant="h4" component="h1" gutterBottom>
        Historique des parties
      </Typography>
      <TableContainer component={Paper}>
        <Table aria-label="game history table">
          <TableHead>
            <TableRow>
              <TableCell>Date</TableCell>
              <TableCell align="left">Catégorie</TableCell>
              <TableCell align="left">Nombre de joueurs</TableCell>
              <TableCell align="left">Position du joueur</TableCell>
              <TableCell align="left">Score du joueur</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {gameHistoryData.map((row) => (
              <TableRow key={row.id}>
                <TableCell component="th" scope="row">
                  {row.date}
                </TableCell>
                <TableCell align="left">{row.category}</TableCell>
                <TableCell align="left">{row.numPlayers}</TableCell>
                <TableCell align="left">{row.playerPosition}</TableCell>
                <TableCell align="left">{row.playerScore}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </Container>
  );
};

export default GameHistory;
