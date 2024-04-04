import React, { useState, useEffect } from 'react';
import {
  Typography,
  TextField,
  Button,
  Container,
  Avatar,
  CircularProgress,
  Snackbar,
  Alert,
} from '@mui/material';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import { useNavigate } from 'react-router-dom';
import Cookies from 'js-cookie';

const LoginPage = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false); // State to track loading state
  const [error, setError] = useState('');
  const [openAlert, setOpenAlert] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();
    setLoading(true); // Set loading state to true when form is submitted

    if (!email || !password) {
      setError('Veuillez remplir tous les champs');
      setOpenAlert(true);
      setLoading(false);
      return;
    }

    try {
      const response = await fetch(`${apiUrl}/users/signin`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
      });

      const data = await response.json();

      if (response.ok) {
        Cookies.set('token', data.token);
        navigate('/');
      } else {
        setError('Email ou mot de passe incorrect');
        setOpenAlert(true);
        console.error('Sign-in failed:', data.error);
      }
    } catch (error) {
      console.error('Error during sign-in:', error);
    } finally {
      setLoading(false); // Reset loading state after response
    }
  };

  useEffect(() => {
    const userToken = Cookies.get('token');
    if (userToken) {
      navigate('/');
    }
  }, []);

  const handleCloseAlert = () => {
    setOpenAlert(false);
  };

  return (
    <Container component="main" maxWidth="xs">
      <div style={{ marginTop: '80px' }}>
        <Avatar style={{ backgroundColor: '#1976d2' }}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Connexion
        </Typography>
        <form onSubmit={handleSubmit} noValidate>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="email"
            label="Adresse e-mail"
            name="email"
            autoComplete="email"
            autoFocus
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Mot de passe"
            type="password"
            id="password"
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          {/* Conditional rendering for the button content */}
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            style={{ marginTop: '16px' }}
            disabled={loading} // Disable button when loading
          >
            {loading ? <CircularProgress size={24} color="inherit" /> : 'Connexion'}
          </Button>
          <Typography
            variant="body2"
            color="textSecondary"
            align="center"
            style={{ marginTop: '16px' }}
          >
            Vous n'avez pas de compte ?{' '}
            <span
              style={{ color: '#1976d2', cursor: 'pointer' }}
              onClick={() => navigate('/signup')}
            >
              Inscrivez-vous
            </span>
          </Typography>
          <Snackbar
            open={openAlert}
            autoHideDuration={6000}
            onClose={handleCloseAlert}
            anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
          >
            <Alert onClose={handleCloseAlert} severity="error">
              {error}
            </Alert>
          </Snackbar>
        </form>
      </div>
    </Container>
  );
};

export default LoginPage;
