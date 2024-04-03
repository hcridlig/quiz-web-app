import React, { useState, useEffect } from "react";
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
} from "@mui/material";

const UserManagement = () => {
  const [users, setUsers] = useState([]);
  const [selectedUserId, setSelectedUserId] = useState(null);
  const [editableUser, setEditableUser] = useState(null);
  const [openSuccessAlert, setOpenSuccessAlert] = useState(false);
  const [openErrorAlert, setOpenErrorAlert] = useState(false);
  const [openDeleteDialog, setOpenDeleteDialog] = useState(false);
  const [userIdToDelete, setUserIdToDelete] = useState(null);
  const [isSaveLoading, setIsSaveLoading] = useState(false);
  const [isDeleteLoading, setIsDeleteLoading] = useState(false);

  useEffect(() => {
    const fetchUsers = async () => {
      const response = await fetch('https://quiz-web-app-five.vercel.app/users/all');
      const data = await response.json();
      const usersWithRole = data.map((user) => ({ ...user, role: user.role ? 'admin' : 'user' }));
      setUsers(usersWithRole);
    };
    fetchUsers();
  }, []);

  const handleDelete = (userId) => {
    setUserIdToDelete(userId);
    setOpenDeleteDialog(true);
  };

  const handleConfirmDelete = async () => {
    setIsDeleteLoading(true);
    try {
      const response = await fetch(`https://quiz-web-app-five.vercel.app/users/${userIdToDelete}`, {
        method: 'DELETE',
      });

      if (response.ok) {
        console.log('Utilisateur supprimé avec succès');
        setUsers(users.filter((user) => user.iduser !== userIdToDelete));
        setOpenDeleteDialog(false);
      } else {
        console.error("Erreur lors de la suppression de l'utilisateur");
      }
    } catch (error) {
      console.error("Erreur lors de la suppression de l'utilisateur, error");
    }
    setIsDeleteLoading(false);
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
        password: editableUser.password,
        role: editableUser.role === 'admin' ? true : false,
      };
      const response = await fetch(`https://quiz-web-app-five.vercel.app/users/${userId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestBody),
      });
      if (response.ok) {
        console.log('Utilisateur mis à jour avec succès');
        setUsers(users.map((user) => (user.iduser === userId ? { ...user, ...editableUser } : user)));
        setSelectedUserId(null);
        setOpenSuccessAlert(true);
      } else {
        console.error("Erreur lors de la mise à jour de l'utilisateur");
        setOpenErrorAlert(true);
      }
    } catch (error) {
      console.error("Erreur lors de la mise à jour de l'utilisateur, error");
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
                  {users.map((user) => (
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
                            onClick={() => handleDelete(user.iduser)}
                            variant="contained"
                            disabled={isDeleteLoading}
                            endIcon={isDeleteLoading && <CircularProgress size={24} />}
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
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
            <Button
              color="primary"
              variant="contained"
              href="/adduser"
              sx={{ mt: 2, mb: 2 }}
            >
              Ajouter un utilisateur
            </Button>
          </Grid>
        </Grid>
        <Snackbar
          open={openSuccessAlert}
          autoHideDuration={4000}
          onClose={handleCloseAlert}
          anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
        >
          <Alert onClose={handleCloseAlert} severity="success" sx={{ width: "100%" }}>
            L'utilisateur a été modifié avec succès !
          </Alert>
        </Snackbar>
        <Snackbar
          open={openErrorAlert}
          autoHideDuration={4000}
          onClose={handleCloseAlert}
          anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
        >
          <Alert onClose={handleCloseAlert} severity="error" sx={{ width: "100%" }}>
            Erreur lors de la modification de l'utilisateur.
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
