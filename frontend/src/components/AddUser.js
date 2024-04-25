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
  IconButton,
  Snackbar,
  Alert
} from "@mui/material";
import ArrowBackIcon from '@mui/icons-material/ArrowBack';

const AddUser = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState("user");
  const [isLoading, setIsLoading] = useState(false);
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");
  const [snackbarSeverity, setSnackbarSeverity] = useState("success");

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
        setSnackbarMessage('Utilisateur ajouté avec succès');
        setSnackbarSeverity('success');
        setOpenSnackbar(true);
      } else {
        // Il y a eu une erreur en ajoutant l'utilisateur
        const data = await response.json();
        console.error('Erreur en ajoutant l\'utilisateur:', data.error);
        setSnackbarMessage(data.error);
        setSnackbarSeverity('error');
        setOpenSnackbar(true);
      }
    } catch (error) {
      console.error('Erreur en envoyant la requête:', error);
      setSnackbarMessage('Erreur en envoyant la requête');
      setSnackbarSeverity('error');
      setOpenSnackbar(true);
    } finally {
      setIsLoading(false);
    }
  };

  const handleCloseSnackbar = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSnackbar(false);
  };

  return (
    <Container component="main" maxWidth="xs" sx={{ mt: openSnackbar ? 20 : 17 }}>
      <Grid container alignItems="center" >
        <Grid item>
          <IconButton color="primary" href="/user-management">
            <ArrowBackIcon />
          </IconButton>
        </Grid>
        <Grid item>
          <Typography variant="h4" component="h1">
            Add User
          </Typography>
        </Grid>
      </Grid>

      <Container>
        <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
          <form onSubmit={handleSubmit}>
            <Grid container spacing={2}>
              <Grid item xs={12}>
                <TextField
                  label="Name"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  fullWidth
                  required
                  size="small"
                  sx={{ maxWidth: 400, mt: 2 }}
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
                  size="small"
                  sx={{ maxWidth: 400 }}
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
                  size="small"
                  sx={{ maxWidth: 400 }}
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
      <Snackbar open={openSnackbar} autoHideDuration={4000} onClose={handleCloseSnackbar}
          anchorOrigin={{ vertical: "top", horizontal: "center" }}>
        <Alert onClose={handleCloseSnackbar} severity={snackbarSeverity} sx={{ width: '100%', mt:10 }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </Container>
  );
};

export default AddUser;
