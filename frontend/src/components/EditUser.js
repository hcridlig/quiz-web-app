import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  TextField,
  Button,
  Container,
  Typography,
  Box,
} from '@mui/material';

function EditUser({ match, history }) {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();
  const userId = 43;

  const [user, setUser] = useState({
    iduser: '',
    username: '',
    email: '',
    password: ''
  });

  const [newUsername, setNewUsername] = useState(user.username);
  const [newEmail, setNewEmail] = useState(user.email);
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');

  useEffect(() => {
    const fetchUser = async () => {
      const response = await fetch(`${apiUrl}/users/${userId}`);
      const data = await response.json();
      setUser(data);
      setNewUsername(data.username);
      setNewEmail(data.email);
    };

    fetchUser();
  }, [userId]);

  const handleSubmit = async e => {
    e.preventDefault();

    const updatedUser = {
      username: newUsername || user.username,
      email: newEmail || user.email,
      currentPassword: currentPassword,
      newPassword: newPassword
    };

    const response = await fetch(`https://quiz-web-app-five.vercel.app/users/${user.iduser}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(updatedUser)
    });

    const data = await response.json();

    setUser(data);
    setNewUsername(data.username);
    setNewEmail(data.email);
    setCurrentPassword('');
    setNewPassword('');
  };

  const handleCancel = () => {
    history.push(`/users/${user.iduser}`);
  };

  return (
    <Container component="main" maxWidth="xs">
      <Typography variant="h4" component="h1" sx={{ mt: 10 }}>
        Edit User
      </Typography>
      <Container>
        <Box component="form" onSubmit={handleSubmit} sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
          <TextField
            label="Username"
            value={newUsername}
            onChange={e => setNewUsername(e.target.value)}
            fullWidth
            margin="normal"
            size="small"
            sx={{ maxWidth: 400 }}
          />
          <TextField
            label="Email"
            value={newEmail}
            onChange={e => setNewEmail(e.target.value)}
            type="email"
            fullWidth
            margin="normal"
            size="small"
            sx={{ maxWidth: 400 }}
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
            <Button type="button" onClick={handleCancel} variant="outlined" color="secondary" sx={{ mr: 1 }}>
              Cancel
            </Button>
            <Button type="submit" variant="contained" color="primary">
              Save Changes
            </Button>
          </Box>
        </Box>
      </Container>
    </Container>
  );
}

export default EditUser;
