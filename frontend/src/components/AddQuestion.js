import React, { useState, useEffect } from 'react';
import {
  TextField,
  Button,
  FormControlLabel,
  Radio,
  RadioGroup,
  FormLabel,
  Typography,
  Box,
  Select,
  MenuItem,
  InputLabel,
  FormControl,
  Container,
  Snackbar,
  Alert,
  IconButton,
} from '@mui/material';
import AddAPhotoIcon from '@mui/icons-material/AddAPhoto';
import CloseIcon from '@mui/icons-material/Close';
import Cookies from 'js-cookie';
import { useDropzone } from 'react-dropzone';

function AddQuestion() {
  const apiUrl = process.env.REACT_APP_API_URL;
  const token = Cookies.get('token');
  const [categories, setCategories] = useState([]);
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('success');
  const [question, setQuestion] = useState({
    title: '',
    option1: '',
    option2: '',
    option3: '',
    option4: '',
    correctAnswer: '',
    category: '',
  });
  const [showNewCategoryForm, setShowNewCategoryForm] = useState(false);
  const [newCategory, setNewCategory] = useState({
    title: '',
    description: '',
    image: '',
    imageName: '',
  });

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await fetch(`${apiUrl}/categories`);
        const data = await response.json();
        setCategories(data);
      } catch (error) {
        console.error('Une erreur s\'est produite lors de la récupération des données :', error);
      }
    };

    fetchCategories();
  }, []);

  const handleInputChange = (e) => {
    setQuestion({
      ...question,
      [e.target.name]: e.target.value,
    });
  };

  const handleNewCategoryChange = (e) => {
    setNewCategory({
      ...newCategory,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch(`${apiUrl}/questions`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(question),
      });

      if (!response.ok) {
        const error = new Error('Une erreur s\'est produite lors de l\'ajout de la question');
        error.response = response;
        throw error;
      }

      setSnackbarOpen(true);
      setSnackbarMessage("Question ajoutée avec succès.");
      setSnackbarSeverity('success');
      handleReset();
    } catch (error) {
      console.error('Erreur lors de l\'ajout de la question :', error);

      let message;
      if (error.response) {
        try {
          const errorData = await error.response.json();
          message = errorData.error || errorData.message || error.message;
        } catch (jsonError) {
          message = error.message;
        }
      } else {
        message = error.message;
      }

      setSnackbarOpen(true);
      setSnackbarMessage(message);
      setSnackbarSeverity('error');
    }
  };

  const handleNewCategorySubmit = async (e) => {
    e.preventDefault();

    try {
      const data = {
        "title": newCategory.title,
        "description": newCategory.description,
        "image": `public/images/${newCategory.imageName}`
      };

      const response = await fetch(`${apiUrl}/categories`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(data),
      });

      if (!response.ok) {
        const error = new Error('Une erreur s\'est produite lors de l\'ajout de la nouvelle catégorie');
        error.response = response;
        throw error;
      }

      const newCategoryData = await response.json();
      setCategories([...categories, newCategoryData]);
      setShowNewCategoryForm(false);
      setNewCategory({
        title: '',
        description: '',
        image: '',
        imageName: '',
      });
      setQuestion({
        ...question,
        category: newCategoryData.idcat,
      });
    } catch (error) {
      console.error('Erreur lors de l\'ajout de la nouvelle catégorie :', error);

      let message;
      if (error.response) {
        try {
          const errorData = await error.response.json();
          message = errorData.error || errorData.message || error.message;
        } catch (jsonError) {
          message = error.message;
        }
      } else {
        message = error.message;
      }

      setSnackbarOpen(true);
      setSnackbarMessage(message);
      setSnackbarSeverity('error');
    }
  };

  const handleReset = () => {
    setQuestion({
      title: '',
      option1: '',
      option2: '',
      option3: '',
      option4: '',
      correctAnswer: '',
      category: '',
    });
  };

  const handleSnackbarClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setSnackbarOpen(false);
  };

  const handleDeleteImage = () => {
    setNewCategory({
      ...newCategory,
      image: '',
      imageName: '',
    });
  };

  const { getRootProps, getInputProps } = useDropzone({
    accept: 'image/*',
    onDrop: (acceptedFiles) => {
      setNewCategory({
        ...newCategory,
        image: acceptedFiles[0],
        imageName: acceptedFiles[0].name,
      });
    },
  });

  return (
    <Container maxWidth="sm" sx={{ mt: 17 }}>
      <Typography variant="h4" component="h1">
        Ajouter une question
      </Typography>
      <form noValidate autoComplete="off" onSubmit={handleSubmit}>
        <TextField
          label="Titre de la question"
          name="title"
          value={question.title}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ mb: 2 }}
        />
        <TextField
          label="Option 1"
          name="option1"
          value={question.option1}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ mb: 2 }}
        />
        <TextField
          label="Option 2"
          name="option2"
          value={question.option2}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ mb: 2 }}
        />
        <TextField
          label="Option 3"
          name="option3"
          value={question.option3}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ mb: 2 }}
        />
        <TextField
          label="Option 4"
          name="option4"
          value={question.option4}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ mb: 2 }}
        />
        <FormLabel component="legend">Réponse correcte</FormLabel>
        <RadioGroup
          row
          aria-label="correctAnswer"
          name="correctAnswer"
          value={question.correctAnswer}
          onChange={handleInputChange}
          sx={{ mb: 2 }}
        >
          <FormControlLabel value="option1" control={<Radio />} label="Option 1" />
          <FormControlLabel value="option2" control={<Radio />} label="Option 2" />
          <FormControlLabel value="option3" control={<Radio />} label="Option 3" />
          <FormControlLabel value="option4" control={<Radio />} label="Option 4" />
        </RadioGroup>
        <FormControl fullWidth sx={{ mb: 2 }}>
          <InputLabel id="category-select-label">Catégorie</InputLabel>
          <Select
            labelId="category-select-label"
            id="category-select"
            value={question.category == '' ? '' : question.category}
            label="Catégorie"
            name="category"
            onChange={(e) => {
              if (e.target.value == '-1') {
                setQuestion({
                  ...question,
                  category: null,
                });
                setShowNewCategoryForm(true);
              } else {
                setQuestion({
                  ...question,
                  category: e.target.value,
                });
                setShowNewCategoryForm(false);
              }
            }}
          >
            {categories.map((category) => (
              <MenuItem key={category.idcat} value={category.idcat}>
                {category.title}
              </MenuItem>
            ))}
            <MenuItem value={-1}>Ajouter une catégorie</MenuItem>
          </Select>
        </FormControl>
      </form>

      {showNewCategoryForm && (
        <Box sx={{ mb: 2 }}>
          <form noValidate autoComplete="off" onSubmit={handleNewCategorySubmit}>
            <TextField
              label="Titre de la catégorie"
              name="title"
              value={newCategory.title}
              onChange={handleNewCategoryChange}
              fullWidth
              margin="normal"
              sx={{ mb: 2 }}
            />
            <TextField
              label="Description de la catégorie"
              name="description"
              value={newCategory.description}
              onChange={handleNewCategoryChange}
              fullWidth
              margin="normal"
              sx={{ mb: 2 }}
            />
            <div {...getRootProps()} style={{ border: '1px dashed #ccc', padding: '20px', textAlign: 'center' }}>
              <input {...getInputProps()} />
              {!newCategory.image && <p>Déposez votre image ici</p>}
              {newCategory.image && (
                <div>
                  <IconButton color="primary" component="label">
                    <AddAPhotoIcon />
                    <input type="file" hidden onChange={(e) => setNewCategory({ ...newCategory, image: e.target.files[0], imageName: e.target.files[0].name })} />
                  </IconButton>
                  <IconButton color="secondary" onClick={handleDeleteImage}>
                    <CloseIcon />
                  </IconButton>
                </div>
              )}
            </div>
            <Button type="submit" variant="contained" color="success" sx={{ mt: 2 }}>
              Ajouter une catégorie
            </Button>
          </form>
        </Box>
      )}

      <Box sx={{ display: 'flex', mt: 2, justifyContent: 'flex-end' }}>
        <Button onClick={handleReset} variant="contained" color="primary" sx={{ mr: 1}}>
          Réinitialiser
        </Button>
        <Button type="submit" variant="contained" color="primary">
          Ajouter une question
        </Button>
      </Box>

      <Snackbar
        open={snackbarOpen}
        autoHideDuration={4000}
        onClose={handleSnackbarClose}
        anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
      >
        <Alert onClose={handleSnackbarClose} severity={snackbarSeverity} sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </Container>
  );
}

export default AddQuestion;
