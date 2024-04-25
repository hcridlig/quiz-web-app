import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  TextField,
  Button,
  Container,
  Typography,
  Box,
  Grid,
  IconButton,
  Skeleton,
  InputAdornment,
  Snackbar,
  Alert,
} from '@mui/material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import Cookies from 'js-cookie';

const SkeletonInput = ({ label, type, sx }) => (
  <TextField
    disabled
    label={label}
    type={type}
    fullWidth
    margin="normal"
    size="small"
    InputProps={{
      startAdornment: (
        <InputAdornment position="start">
          <Skeleton variant="text" width={50} sx={{ mr: 1 }} />
        </InputAdornment>
      ),
    }}
    sx={{
      '& .MuiInputBase-input': { color: 'transparent' },
      '& .MuiInputLabel-root': { color: 'text.disabled' },
      ...sx,
    }}
  />
);

const EditUser = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();

  const [user, setUser] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const playerId = localStorage.getItem('playerId');
  const [newUsername, setNewUsername] = useState('');
  const [newEmail, setNewEmail] = useState('');
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const token = Cookies.get('token');

  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('success');

  useEffect(() => {
    const fetchUser = async () => {
      setIsLoading(true);
      const response = await fetch(`${apiUrl}/users/${playerId}`);
      const data = await response.json();
      setUser(data);
      setNewUsername(data.username);
      setNewEmail(data.email);
      setIsLoading(false);
    };

    fetchUser();
  }, []);

  const handleSubmit = async e => {
    e.preventDefault();

    const updatedUser = {
      username: newUsername || user.username,
      email: newEmail || user.email,
      currentPassword: currentPassword,
      newPassword: newPassword,
      page: 'editUser'
    };

    const response = await fetch(`${apiUrl}/users/${playerId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify(updatedUser)
    });

    const data = await response.json();

    setUser(data);
    setNewUsername(data.username);
    setNewEmail(data.email);
    setCurrentPassword('');
    setNewPassword('');

    if(response.ok) {
      setSnackbarMessage('User updated successfully');
      setSnackbarSeverity('success');
      setOpenSnackbar(true);
      document.cookie = `token=${data.token}; path=/;`;
    } else {
      setSnackbarMessage(data.error);
      setSnackbarSeverity('error');
      setOpenSnackbar(true);
    }
  };

  return (
    <Container component="main" maxWidth="xs" sx={{mt: openSnackbar ? 20 : 17 }}>
      <Grid container alignItems="center">
        <Grid item>
          <IconButton color="primary" href="/">
            <ArrowBackIcon />
          </IconButton>
        </Grid>
        <Grid item>
          <Box sx={{ position: 'relative' }}>
            <Typography variant="h4" component="h1">
              Edit User
            </Typography>
            <Snackbar
              open={openSnackbar}
              autoHideDuration={4000}
              onClose={() => setOpenSnackbar(false)}
              anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
              sx={{mt:10 }}
            >
              <Alert onClose={() => setOpenSnackbar(false)} severity={snackbarSeverity} sx={{ width: '100%' }}>
                {snackbarMessage}
              </Alert>
            </Snackbar>
          </Box>
        </Grid>
      </Grid>
      {isLoading ? (
        <Container>
          <SkeletonInput label="Username" type="text" sx={{ maxWidth: 400, mb: 1 }} />
          <SkeletonInput label="Email" type="email" sx={{ maxWidth: 400, mb: 1 }} />
          <SkeletonInput label="Current Password" type="password" sx={{ maxWidth: 400, mb: 1 }} />
          <SkeletonInput label="New Password" type="password" sx={{ maxWidth: 400, mb: 1 }} />
          <Box sx={{ display: 'flex', justifyContent: 'flex-end', width: '100%', mt: 2 }}>
            <Button disabled variant="contained" color="primary">
              Save Changes
            </Button>
          </Box>
        </Container>
      ) : (
        <Container>
          <Box component="form" onSubmit={handleSubmit} sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
            <TextField
              label={newUsername ? null : "Username"}
              value={newUsername}
              onChange={e => setNewUsername(e.target.value)}
              fullWidth
              margin="normal"
              size="small"
              sx={{ maxWidth: 400 }}
              InputLabelProps={{
                shrink: !newUsername,
              }}
            />
            <TextField
              label={newEmail ? null : "Email"}
              value={newEmail}
              onChange={e => setNewEmail(e.target.value)}
              type="email"
              fullWidth
              margin="normal"
              size="small"
              sx={{ maxWidth: 400 }}
              InputLabelProps={{
                shrink: !newEmail,
              }}
            />
            <TextField
              label="Current Password"
              value={currentPassword}
              onChange={e => setCurrentPassword(e.target.value)}
              type="password"
              fullWidth
              margin="normal"
              size="small"
              sx={{ maxWidth: 400 }}
            />
            <TextField
              label="New Password"
              value={newPassword}
              onChange={e => setNewPassword(e.target.value)}
              type="password"
              fullWidth
              margin="normal"
              size="small"
              sx={{ maxWidth: 400 }}
            />
            <Box sx={{ display: 'flex', justifyContent: 'flex-end', width: '100%', mt: 2 }}>
              <Button type="submit" variant="contained" color="primary">
                Save Changes
              </Button>
            </Box>
          </Box>
        </Container>
      )}
    </Container>
  );
}

export default EditUser;
