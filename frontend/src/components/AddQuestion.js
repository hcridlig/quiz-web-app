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
  FormControl
} from '@mui/material';
import { useNavigate } from 'react-router-dom';

function AddQuestion() {
  const apiUrl = process.env.REACT_APP_API_URL;
  const [question, setQuestion] = useState({
    title: '',
    option1: '',
    option2: '',
    option3: '',
    option4: '',
    correctAnswer: '',
    category: '',
  });

  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetchCategories = async () => {
      const response = await fetch(`${apiUrl}/categories`); // Replace with your API URL
      const data = await response.json();
      setCategories(data);
    };

    fetchCategories();
  }, []);

  const navigate = useNavigate();

  const handleInputChange = (e) => {
    setQuestion({
      ...question,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Add logic to submit the question here.
    console.log(question);
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

  return (
    <Box sx={{ mt: 12, display: 'flex', flexDirection: 'column', justifyContent: 'center', paddingLeft: "35%", }}>
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
          sx={{ width: '50%' }}
          mb={2}
        />
        <br />
        <TextField
          label="Option 1"
          name="option1"
          value={question.option1}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ width: '50%' }}
          mb={2}
        />
        <br />
        <TextField
          label="Option 2"
          name="option2"
          value={question.option2}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ width: '50%' }}
          mb={2}
        />
        <br />
        <TextField
          label="Option 3"
          name="option3"
          value={question.option3}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ width: '50%' }}
          mb={2}
        />
        <br />
        <TextField
          label="Option 4"
          name="option4"
          value={question.option4}
          onChange={handleInputChange}
          fullWidth
          margin="normal"
          sx={{ width: '50%' }}
          mb={2}
        />
        <br />
        <FormLabel component="legend">Correct Answer</FormLabel>
        <RadioGroup
          row
          aria-label="correctAnswer"
          name="correctAnswer"
          value={question.correctAnswer}
          onChange={handleInputChange}
        >
          <FormControlLabel value="option1" control={<Radio />} label="Option 1" />
          <FormControlLabel value="option2" control={<Radio />} label="Option 2" />
          <FormControlLabel value="option3" control={<Radio />} label="Option 3" />
          <FormControlLabel value="option4" control={<Radio />} label="Option 4" />
        </RadioGroup>
        <FormControl fullWidth sx={{ width: '50%', mb: 2 }}>
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
        <Box sx={{ display: 'flex', mt: 2, paddingLeft: "25%"}}>
          <Box sx={{ display: 'flex' }}>
            <Button onClick={handleCancel} variant="outlined" color="secondary" sx={{ mt: 2, mr: 1 }}>
              Cancel
            </Button>
            <Button onClick={handleReset} variant="contained" color="primary" sx={{ mt: 2, mr: 1}}>
              Reset
            </Button>
            <Button type="submit" variant="contained" color="primary" sx={{ mt: 2, mr: 1 }}>
              Add Question
            </Button>
          </Box>
        </Box>
      </form>
    </Box>
  );
}

export default AddQuestion;
