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
  Skeleton,
  Box,
  Grid,
  Icon,
} from '@mui/material';
import EmojiEventsIcon from '@mui/icons-material/EmojiEvents';
import EmojiEventsOutlinedIcon from '@mui/icons-material/EmojiEventsOutlined';
import EmojiEventsRoundedIcon from '@mui/icons-material/EmojiEventsRounded';

const Ranking = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const [leaderboardData, setLeaderboardData] = useState([]);

  // Ajouter les états pour suivre les rangs
  const [firstRank, setFirstRank] = useState(null);
  const [secondRank, setSecondRank] = useState(null);
  const [thirdRank, setThirdRank] = useState(null);

  const goldColor = '#FFD700';
  const silverColor = '#C0C0C0';
  const bronzeColor = '#CD7F32';

  // Couleurs pour les icônes de trophée
  const trophyColors = {
    1: goldColor,
    2: silverColor,
    3: bronzeColor,
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const resultsResponse = await fetch(`${apiUrl}/results`);
        const usersResponse = await fetch(`${apiUrl}/users/all`);

        if (!resultsResponse.ok || !usersResponse.ok) {
          throw new Error('Error fetching data');
        }

        const results = await resultsResponse.json();
        const users = await usersResponse.json();

        const combinedData = results.map((result) => {
          const user = users.find((user) => user.iduser === result.iduser);
          return {
            id: result.idresult,
            name: user.username,
            score: result.score,
          };
        });

        // Filtrer pour obtenir le meilleur résultat de chaque utilisateur
        const bestResults = {};
        combinedData.forEach((data) => {
          if (!bestResults[data.name] || bestResults[data.name].score < data.score) {
            bestResults[data.name] = data;
          }
        });

        setLeaderboardData(Object.values(bestResults));
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  // Trier le tableau leaderboardData en fonction du score
  const sortedLeaderboardData = [...leaderboardData].sort((a, b) => b.score - a.score);

  // Mettre à jour les états des rangs après avoir trié les données
  useEffect(() => {
    setFirstRank(sortedLeaderboardData[0]?.id);
    setSecondRank(sortedLeaderboardData[1]?.id);
    setThirdRank(sortedLeaderboardData[2]?.id);
  }, [sortedLeaderboardData]);

  // Composant pour les lignes du skeleton loader
  const TableRowSkeleton = () => (
    <TableRow>
      <TableCell>
        <Skeleton animation="wave" variant="text" width={40} />
      </TableCell>
      <TableCell align="left">
        <Skeleton animation="wave" variant="text" width={150} />
      </TableCell>
      <TableCell align="right">
        <Skeleton animation="wave" variant="text" width={100} />
      </TableCell>
    </TableRow>
  );

  // Composant pour une marche du podium
  const PodiumStep = ({ rank, name, score }) => (
    <Grid item xs={4} container direction="column" alignItems="center" justifyContent="center">
      <Grid item>
        {rank === 1 && <Icon color="action"><EmojiEventsIcon fontSize="large" style={{ color: trophyColors[rank] }} /></Icon>}
        {rank === 2 && <Icon color="action"><EmojiEventsOutlinedIcon fontSize="large" style={{ color: trophyColors[rank] }} /></Icon>}
        {rank === 3 && <Icon color="action"><EmojiEventsRoundedIcon fontSize="large" style={{ color: trophyColors[rank] }} /></Icon>}
      </Grid>
      <Grid item>
        <Typography variant="h6" component="div">
          {rank}. {name}
        </Typography>
        <Typography variant="subtitle1" component="div">
          Score: {score}
        </Typography>
      </Grid>
    </Grid>
  );

  // Composant pour le podium
  const Podium = ({ podiumData }) => (
    <Grid container spacing={2} justifyContent="center">
      {podiumData.map((row, index) => (
        <PodiumStep key={row.id} rank={index + 1} name={row.name} score={row.score} />
      ))}
    </Grid>
  );

  return (
    <Container maxWidth="md" sx={{ mt: 17 }}>
      <Typography sx={{ mb: 3 }} variant="h4" component="h1" gutterBottom>
        Classement général
      </Typography>
      {sortedLeaderboardData.length > 0 && (
        <Box mb={2} >
          <Podium podiumData={sortedLeaderboardData.slice(0, 3)} />
        </Box>
      )}
      <TableContainer component={Paper}>
        <Table aria-label="classement table">
          <TableBody>
            {leaderboardData.length === 0 ? (
              // Afficher 5 lignes de skeleton loader pendant le chargement
              Array.from(Array(3).keys()).map((_) => (
                <TableRowSkeleton key={_} />
              ))
            ) : (
              sortedLeaderboardData.slice(3).map((row) => {
                const backgroundColor =
                  row.id === firstRank
                    ? goldColor
                    : row.id === secondRank
                    ? silverColor
                    : row.id === thirdRank
                    ? bronzeColor
                    : '';

                return (
                  <TableRow key={row.id} sx={{ backgroundColor }}>
                    <TableCell component="th" scope="row">
                      {sortedLeaderboardData.indexOf(row) + 1}
                    </TableCell>
                    <TableCell align="left">{row.name}</TableCell>
                    <TableCell align="right">{row.score}</TableCell>
                  </TableRow>
                );
              })
            )}
          </TableBody>
        </Table>
      </TableContainer>
    </Container>
  );
};

export default Ranking;
