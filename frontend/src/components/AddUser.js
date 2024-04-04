import React, { useState } from "react";
import {
  Container,
  Box,
  Grid,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  Button,
  Typography,
  CircularProgress,
  Alert,
  IconButton
} from "@mui/material";
import ArrowBackIcon from '@mui/icons-material/ArrowBack';

const AddUser = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState("user");
  const [isLoading, setIsLoading] = useState(false);
  const [alert, setAlert] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);

    const newUser = {
      username: name,
      email: email,
      password: password,
      role: role
    };

    try {
      const response = await fetch(`${apiUrl}/users`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(newUser)
      });

      if (response.ok) {
        // L'utilisateur a été ajouté avec succès
        console.log('Utilisateur ajouté avec succès');
        setName("");
        setEmail("");
        setPassword("");
        setRole("user");
        setAlert({ severity: 'success', message: 'Utilisateur ajouté avec succès' });
      } else {
        // Il y a eu une erreur en ajoutant l'utilisateur
        const data = await response.json();
        console.error('Erreur en ajoutant l\'utilisateur:', data.error);
        setAlert({ severity: 'error', message: data.error });
      }
    } catch (error) {
      console.error('Erreur en envoyant la requête:', error);
      setAlert({ severity: 'error', message: 'Erreur en envoyant la requête' });
    } finally {
      setIsLoading(false);
    }

    setTimeout(() => {
      setAlert(null);
    }, 3000);
  };

  return (
    <Container component="main" maxWidth="xs">
      <Grid container spacing={2} sx={{ mt: 10 }}>
        <Grid item xs={2}>
          <IconButton color="primary" href="/usermanagement">
            <ArrowBackIcon />
          </IconButton>
        </Grid>
        <Grid item xs={10}>
          <Typography variant="h4" component="h1">
            Add User
          </Typography>
        </Grid>
      </Grid>
      {alert && (
        <Alert severity={alert.severity}>
          {alert.message}
        </Alert>
      )}
      <Container maxWidth="sm">
        <Box my={4}>
          <form onSubmit={handleSubmit}>
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <TextField
                  label="Name"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  fullWidth
                  required
                />
              </Grid>
              <Grid item xs={12}>
                <TextField
                  label="Email"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  fullWidth
                  required
                />
              </Grid>
              <Grid item xs={12}>
                <TextField
                  label="Password"
                  type="password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  fullWidth
                  required
                />
              </Grid>
              <Grid item xs={12}>
                <FormControl fullWidth>
                  <InputLabel id="role-select-label">Role</InputLabel>
                  <Select
                    labelId="role-select-label"
                    id="role-select"
                    value={role}
                    label="Role"
                    onChange={(e) => setRole(e.target.value)}
                    required
                  >
                    <MenuItem value="user">User</MenuItem>
                    <MenuItem value="admin">Admin</MenuItem>
                  </Select>
                </FormControl>
              </Grid>
              <Grid item xs={12}>
                <Button type="submit" color="primary" variant="contained" fullWidth disabled={isLoading}>
                  {isLoading ? <CircularProgress size={24} color="inherit" /> : 'Ajouter un utilisateur'}
                </Button>
              </Grid>
            </Grid>
          </form>
        </Box>
      </Container>
    </Container>
  );
};

export default AddUser;
