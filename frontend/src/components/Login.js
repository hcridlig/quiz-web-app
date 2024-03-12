import React, { useState } from 'react';
import {
  Grid,
  Typography,
  TextField,
  Button,
  Container,
  Avatar,
} from '@material-ui/core';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import { useNavigate } from 'react-router-dom';

const LoginPage = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    
    try {
      const response = await fetch('http://localhost:4000/users/signin', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
      });

      const data = await response.json();

      if (response.ok) {
        // Save the token to local storage or state
        console.log('Successfully signed in!');
        console.log('JWT Token:', data.token);
      } else {
        console.error('Sign-in failed:', data.error);
      }
    } catch (error) {
      console.error('Error during sign-in:', error);
    }
  };

  return (
    <Container component="main" maxWidth="xs">
      <div style={{ marginTop: '80px' }}>
        <Avatar style={{ backgroundColor: '#1976d2' }}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Sign In
        </Typography>
        <form onSubmit={handleSubmit} noValidate>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="email"
            label="Email Address"
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
            label="Password"
            type="password"
            id="password"
            autoComplete="current-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            style={{ marginTop: '16px' }}
          >
            Sign In
          </Button>
          <Typography
            variant="body2"
            color="textSecondary"
            align="center"
            style={{ marginTop: '16px' }}
          >
            Already have an account ?{' '}
            <span
              style={{ color: '#1976d2', cursor: 'pointer' }}
              onClick={() => navigate('/signup')}
            >
              Sign Up
            </span>
          </Typography> 
        </form>
      </div>
    </Container>
  );
};

export default LoginPage;
