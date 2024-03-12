import React, { useState } from 'react';
import {
  Grid,
  Typography,
  TextField,
  Button,
  Container,
  Avatar,
  IconButton,
  InputAdornment,
} from '@material-ui/core';
import { Visibility, VisibilityOff } from '@material-ui/icons';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import { useNavigate } from 'react-router-dom';

const SignUpPage = () => {
  const navigate = useNavigate();
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (password !== confirmPassword) {
        // Handle password mismatch error
        setError('Passwords do not match.');
        return;
      }
  
      try {
        const response = await fetch('http://localhost:4000/users', {
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
        console.log(response.status);
        if (response.status === 200) {
          console.log('User registered successfully!');
          navigate('/signin');
        } else {
          const responseBody = await response.json();
          if (response.status === 400 && responseBody.error) {
            // Handle specific error for duplicate email or username
            //console.error('Registration failed:', responseBody.error);
            setError(responseBody.error);
          } else {
           // Handle other registration errors
          //console.error('Registration failed:', response.statusText);
          setError('An error occurred during registration. Please try again later.');
          }
        }
      } catch (error) {
        // Handle network or other errors
        //console.error('Error during registration:', error.message);
        setError('An error occurred during registration. Please try again later.');
      }
    };
  

  const handleTogglePassword = () => {
    setShowPassword(!showPassword);
  };

  return (
    <Container component="main" maxWidth="xs">
      <div style={{ marginTop: '80px' }}>
        <Avatar style={{ backgroundColor: '#1976d2' }}>
          <LockOutlinedIcon />
        </Avatar>
        <Typography component="h1" variant="h5">
          Sign Up
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
            id="username"
            label="Username"
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
            label="Password"
            type={showPassword ? 'text' : 'password'}
            id="password"
            autoComplete="new-password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            InputProps={{
              endAdornment: (
                <InputAdornment position="end">
                  <IconButton onClick={handleTogglePassword} edge="end">
                    {showPassword ? <Visibility /> : <VisibilityOff />}
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
            label="Confirm Password"
            type={showPassword ? 'text' : 'password'}
            id="confirmPassword"
            autoComplete="new-password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            
          />
          {error && <div style={{ color: 'red', marginTop: '8px' }}>{error}</div>}
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            style={{ marginTop: '16px' }}
          >
            Sign Up
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
              onClick={() => navigate('/signin')}
            >
              Sign In
            </span>
          </Typography>                                                                                                                                                                                                                                                                                                           
        </form>
      </div>
    </Container>
  );
};

export default SignUpPage;
