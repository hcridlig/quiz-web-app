import React from 'react';
import { Button, Typography, Box, Container } from '@mui/material';

const QuizHomePage = () => {
  const handleSinglePlayer = () => {
    // Handle single player button click here
  };

  const handleMultiPlayer = () => {
    // Handle multiplayer button click here
  };

  return (
    <Container maxWidth="sm" sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', minHeight: '100vh', padding: 4 }}>
      <Typography variant="h4" align="center" sx={{ marginBottom: 4 }}>
        Bienvenue dans l'application de Quiz !
      </Typography>
      <Box textAlign="center">
        <Typography variant="h6">Mesurez vos connaissances dans différentes catégories.</Typography>
        <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2, marginTop: 2 }}>
          <Button href="/category" variant="contained" color="primary" onClick={handleSinglePlayer} sx={{ fontSize: '1.2rem', padding: '1rem 2rem' }}>Solo</Button>
          <Button href="/" variant="contained" color="secondary" onClick={handleMultiPlayer} sx={{ fontSize: '1.2rem', padding: '1rem 2rem' }}>Multijoueur</Button>
        </Box>
      </Box>
    </Container>
  );
};

export default QuizHomePage;
