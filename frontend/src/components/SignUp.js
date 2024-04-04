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
  InputAdornment,
  IconButton,
} from '@mui/material';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import { Visibility, VisibilityOff } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';
import Cookies from 'js-cookie';

const SignUpPage = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false); // State to track loading state
  const [error, setError] = useState(null);
  const [openAlert, setOpenAlert] = useState(false);
  const [token, setToken] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (!email || !username || !password || !confirmPassword) {
      setError('Veuillez remplir tous les champs.');
      setOpenAlert(true);
      return;
    }

    if (password !== confirmPassword) {
      setError('Les mots de passe ne correspondent pas.');
      setOpenAlert(true);
      return;
    }

    setLoading(true);

    try {
      const response = await fetch(`${apiUrl}/users`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email,
          username,
          password,
        }),
      });

      if (response.ok) {
        console.log('User registered successfully!');
        navigate('/signin');
      } else {
        const responseBody = await response.json();
        if (response.status === 400 && responseBody.error) {
          setError(responseBody.error);
        } else {
          setError('Une erreur est survenue lors de l\'inscription. Veuillez réessayer plus tard.');
        }
        setOpenAlert(true);
      }
    } catch (error) {
      setError(error.message);
      setOpenAlert(true);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    // Check if token exists in cookies
    const userToken = Cookies.get('token');
    if (userToken) {
      setToken(userToken);
      navigate('/'); // Redirect to dashboard if token exists
    }
  }, [navigate]);

  // Redirect to dashboard if token exists
  if (token) {
    navigate('/');
  }

  const handleCloseAlert = () => {
    setOpenAlert(false);
  };

  const handleTogglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  };

  return (
    <Container component="main" maxWidth="xs">
      <div style={{ marginTop: '80px' }}>
        <Avatar style={{ backgroundColor: '#1976d2' }}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Créez votre compte
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
            id="username"
            label="Identifiant"
            name="username"
            autoComplete="username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Mot de passe"
            type={showPassword ? 'text' : 'password'}
            id="password"
            autoComplete="new-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            InputProps={{
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton
                    onClick={handleTogglePasswordVisibility}
                    edge="end"
                    aria-label="toggle password visibility"
                  >
                    {showPassword ? <VisibilityOff /> : <Visibility />}
                  </IconButton>
                </InputAdornment>
              ),
            }}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="confirmPassword"
            label="Confirmation du mot de passe"
            type={showPassword ? 'text' : 'password'}
            id="confirmPassword"
            autoComplete="new-password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            style={{ marginTop: '16px' }}
            disabled={loading}
          >
            {loading ? <CircularProgress size={24} color="inherit" /> : 'Inscription'}
          </Button>
          <Typography
            variant="body2"
            color="textSecondary"
            align="center"
            style={{ marginTop: '16px' }}
          >
            Vous avez déjà un compte ?{' '}
            <span
              style={{ color: '#1976d2', cursor: 'pointer' }}
              onClick={() => navigate('/signin')}
            >
              Connectez-vous
            </span>
          </Typography>
          <Snackbar
            open={openAlert}
            autoHideDuration={6000}
            onClose={handleCloseAlert}
            anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
          >
            <Alert onClose={handleCloseAlert} severity="info">
              {error}
            </Alert>
          </Snackbar>
        </form>
      </div>
    </Container>
  );
};

export default SignUpPage;
