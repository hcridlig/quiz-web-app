import React, { useState, useEffect } from "react";
import Cookies from "js-cookie";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Button,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Grid,
  Container,
  Box,
  TextField,
  Alert,
  Snackbar,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  CircularProgress,
  Skeleton
} from "@mui/material";

const UserManagement = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const [users, setUsers] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState(null);
  const [editableUser, setEditableUser] = useState(null);
  const [openSuccessAlert, setOpenSuccessAlert] = useState(false);
  const [openErrorAlert, setOpenErrorAlert] = useState(false);
  const [openDeleteDialog, setOpenDeleteDialog] = useState(false);
  const [userIdToDelete, setUserIdToDelete] = useState(null);
  const [isSaveLoading, setIsSaveLoading] = useState(false);
  const [deletingUserId, setDeletingUserId] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [snackbarMessage, setSnackbarMessage] = useState('');

  useEffect(() => {
    const fetchUsers = async () => {
      const response = await fetch(`${apiUrl}/users/all`);
      const data = await response.json();
      const usersWithRole = data.map((user) => ({ ...user, role: user.role ? 'admin' : 'user' }));
      setUsers(usersWithRole);
      setIsLoading(false);
    };
    fetchUsers();
  }, []);

  const handleDelete = (userId, event) => {
    event.stopPropagation();
  
    setUserIdToDelete(userId);
    setOpenDeleteDialog(true);
  };   

  const handleConfirmDelete = async () => {
    setDeletingUserId(userIdToDelete); // Set the deletingUserId state before sending the request
    setOpenDeleteDialog(false);
  
    try {
      const response = await fetch(`${apiUrl}/users/${userIdToDelete}`, {
        method: 'DELETE',
      });
  
      if (response.ok) {
        setUsers(users.filter((user) => user.iduser !== userIdToDelete));
        setSnackbarMessage('Utilisateur supprimé avec succès !')
        setOpenSuccessAlert(true);
      } else {
        setSnackbarMessage("Erreur lors de la suppression de l'utilisateur")
        setOpenErrorAlert(true); 
      }
    } catch (error) {
      setSnackbarMessage("Erreur lors de la suppression de l'utilisateur")
      setOpenErrorAlert(true);
    }
    setDeletingUserId(null); 
  };  

  const handleRoleChange = (userId, newRole) => {
    setUsers(
      users.map((user) =>
        user.iduser === userId ? { ...user, role: newRole } : user
      )
    );
  };

  const handleRowClick = (userId) => {
    if (selectedUserId === userId) {
      setSelectedUserId(null);
      setEditableUser(null);
    } else {
      const user = users.find((user) => user.iduser === userId);
      setSelectedUserId(userId);
      setEditableUser({ ...user, password: "" });
    }
  };

  const handleUserUpdate = (userId, updatedFields) => {
    setEditableUser({
      ...editableUser,
      ...updatedFields,
    });
  };

  const handleSave = async (userId) => {
    setIsSaveLoading(true);
    try {
      const userToUpdate = users.find((user) => user.iduser === userId);
      const requestBody = {
        username: editableUser.username,
        email: editableUser.email,
        role: editableUser.role === 'admin' ? true : false,
        ...(editableUser.password && { newPassword: editableUser.password }), // Only include the password field if it's not empty
      };
  
      // Get the token from the cookie
      const token = Cookies.get('token');
  
      // Include the token in the request headers
      const response = await fetch(`${apiUrl}/users/${userId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}` // Add the token to the Authorization header
        },
        body: JSON.stringify(requestBody),
      });
  
      if (response.ok) {
        setUsers(users.map((user) => (user.iduser === userId ? { ...user, ...editableUser } : user)));
        setSelectedUserId(null);
        setSnackbarMessage("Utilisateur mis à jour avec succès");
        setOpenSuccessAlert(true);
      } else {
        setSnackbarMessage("Erreur lors de la mise à jour de l'utilisateur");
        setOpenErrorAlert(true);
      }
    } catch (error) {
      setSnackbarMessage("Erreur lors de la mise à jour de l'utilisateur");
      setOpenErrorAlert(true);
    }
    setIsSaveLoading(false);
  };


  const handleCloseAlert = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSuccessAlert(false);
    setOpenErrorAlert(false);
  };

  const handleAddUserClick = () => {
    // Ici, vous pouvez ajouter la logique pour afficher un formulaire d'ajout d'utilisateur,
    // comme ouvrir une boîte de dialogue ou afficher un composant de formulaire.
  };

  return (
    <Container maxWidth="md" sx={{ mt: 15 }}>
      <Box my={4}>
        <Grid container justifyContent="center">
          <Grid item xs={10}>
            <TableContainer component={Paper}>
              <Table sx={{ minWidth: 650 }} aria-label="simple table">
                <TableHead>
                  <TableRow>
                    <TableCell sx={{ fontWeight: "bold" }}>Name</TableCell>
                    <TableCell align="right" sx={{ fontWeight: "bold" }}>Email</TableCell>
                    <TableCell align="right" sx={{ fontWeight: "bold" }}>Role</TableCell>
                    <TableCell align="right" sx={{ fontWeight: "bold" }}>Actions</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {isLoading ? (
                    [1, 2, 3].map((rowIndex) => (
                      <TableRow key={rowIndex}>
                        {[1, 2, 3, 4].map((columnIndex) => (
                          <TableCell key={columnIndex}>
                            <Skeleton variant="text" />
                          </TableCell>
                        ))}
                      </TableRow>
                    ))
                  ) : (
                    users.map((user) => (
                      <React.Fragment key={user.iduser}>
                        <TableRow onClick={() => handleRowClick(user.iduser)}>
                          <TableCell component="th" scope="row">
                            {user.username}
                          </TableCell>
                          <TableCell align="right">{user.email}</TableCell>
                          <TableCell align="right">{user.role}</TableCell>
                          <TableCell align="right">
                            <Button
                              color="error"
                              onClick={(event) => handleDelete(user.iduser, event)}
                              variant="contained"
                              disabled={deletingUserId === user.iduser}
                              endIcon={deletingUserId === user.iduser && <CircularProgress size={24} />}
                            >
                              Delete
                            </Button>
                          </TableCell>
                        </TableRow>
                        {selectedUserId === user.iduser && (
                          <TableRow>
                            <TableCell colSpan={4}>
                              <TextField
                                label="Name"
                                value={editableUser?.username || ""}
                                onChange={(e) => {
                                  handleUserUpdate(selectedUserId, { username: e.target.value });
                                }}
                                fullWidth
                                margin="normal"
                              />
                              <TextField
                                label="Email"
                                value={editableUser?.email || ""}
                                onChange={(e) => {
                                  handleUserUpdate(selectedUserId, { email: e.target.value });
                                }}
                                fullWidth
                                margin="normal"
                              />
                              <TextField
                                label="New Password"
                                type="password"
                                value={editableUser?.password || ""}
                                onChange={(e) => {
                                  handleUserUpdate(selectedUserId, { password: e.target.value });
                                }}
                                fullWidth
                                margin="normal"
                              />
                              <FormControl fullWidth margin="normal">
                                <InputLabel id="role-select-label-edit">Role</InputLabel>
                                <Select
                                  labelId="role-select-label-edit"
                                  id="role-select-edit"
                                  value={editableUser?.role || ""}
                                  label="Role"
                                  onChange={(e) => {
                                    handleUserUpdate(selectedUserId, { role: e.target.value });
                                  }}
                                >
                                  <MenuItem value="admin">Admin</MenuItem>
                                  <MenuItem value="user">User</MenuItem>
                                </Select>
                              </FormControl>
                              <Button
                                color="primary"
                                variant="contained"
                                onClick={() => handleSave(selectedUserId)}
                                sx={{ mt: 2 }}
                                disabled={isSaveLoading}
                                endIcon={isSaveLoading && <CircularProgress size={24} />}
                              >
                                Valider
                              </Button>
                            </TableCell>
                          </TableRow>
                        )}
                      </React.Fragment>
                    ))
                  )}
                </TableBody>
              </Table>
            </TableContainer>
            <Button
              color="primary"
              variant="contained"
              href="/add-user"
              sx={{ mt: 2, mb: 2 }}
            >
              Ajouter un utilisateur
            </Button>
          </Grid>
        </Grid>
        <Snackbar
          open={openSuccessAlert}
          autoHideDuration={3000}
          onClose={handleCloseAlert}
          anchorOrigin={{ vertical: "top", horizontal: "center" }}
        >
          <Alert onClose={handleCloseAlert} severity="success" variant="filled" sx={{ width: "100%" }}>
            {snackbarMessage}
          </Alert>
        </Snackbar>
        <Snackbar
          open={openErrorAlert}
          autoHideDuration={3000}
          onClose={handleCloseAlert}
          anchorOrigin={{ vertical: "top", horizontal: "center" }}
        >
          <Alert onClose={handleCloseAlert} severity="error" variant="filled" sx={{ width: "100%" }}>
            {snackbarMessage}
          </Alert>
        </Snackbar>
        <Dialog
          open={openDeleteDialog}
          onClose={() => setOpenDeleteDialog(false)}
          aria-labelledby="alert-dialog-title"
          aria-describedby="alert-dialog-description"
        >
          <DialogTitle id="alert-dialog-title">
            {"Supprimer l'utilisateur ?"}
          </DialogTitle>
          <DialogContent>
            <DialogContentText id="alert-dialog-description">
              Cette action est irréversible. Voulez-vous vraiment supprimer cet utilisateur ?
            </DialogContentText>
          </DialogContent>
          <DialogActions>
            <Button onClick={() => setOpenDeleteDialog(false)}>Annuler</Button>
            <Button onClick={handleConfirmDelete} autoFocus>
              Supprimer
            </Button>
          </DialogActions>
        </Dialog>
      </Box>
    </Container>
  );
};

export default UserManagement;
