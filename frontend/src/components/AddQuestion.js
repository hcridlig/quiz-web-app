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
} from '@mui/material';
import Cookies from 'js-cookie';
import { useNavigate } from 'react-router-dom';

function AddQuestion() {
  const apiUrl = process.env.REACT_APP_API_URL;
  const token = Cookies.get('token');
  const navigate = useNavigate();
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

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        const response = await fetch(`${apiUrl}/categories`); // Replace with your API URL
        const data = await response.json();
        setCategories(data); 
      } catch (error) {
        console.error('An error occurred while fetching data:', error);
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
  
      if (response.ok) {
        // Question added successfully
        setSnackbarOpen(true);
        setSnackbarMessage("Question ajoutée avec succès.");
        setSnackbarSeverity('success');
        // Reset the form
        handleReset();
      } else {
        // Handle error response from the server
        const errorData = await response.json();
        setSnackbarOpen(true);
        setSnackbarMessage(errorData.error);
        setSnackbarSeverity('error');
      }
    } catch (error) {
      // Handle network error
      setSnackbarOpen(true);
      setSnackbarMessage("An error occurred. Please try again.");
      setSnackbarSeverity('error');
    }
  };

  const handleCancel = () => {
    navigate(-1);
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

  return (
    <Container maxWidth="sm" sx={{ mt: 12 }}>
      <Typography variant="h4" component="h1">
        Add question
      </Typography>
      <form noValidate autoComplete="off" onSubmit={handleSubmit} >
        <TextField
          label="Question Title"
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
        <FormLabel component="legend">Correct Answer</FormLabel>
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
          <InputLabel id="category-select-label">Category</InputLabel>
          <Select
            labelId="category-select-label"
            id="category-select"
            value={question.category}
            label="Category"
            name="category"
            onChange={handleInputChange}
          >
            {categories.map((category) => (
              <MenuItem key={category.idcat} value={category.idcat}>{category.title}</MenuItem>
            ))}
          </Select>
        </FormControl>
        <Box sx={{ display: 'flex', mt: 2, justifyContent: 'flex-end' }}>
          <Button onClick={handleCancel} variant="outlined" color="secondary" sx={{ mr: 1 }}>
            Cancel
          </Button>
          <Button onClick={handleReset} variant="contained" color="primary" sx={{ mr: 1}}>
            Reset
          </Button>
          <Button type="submit" variant="contained" color="primary">
            Add Question
          </Button>
        </Box>
      </form>
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
