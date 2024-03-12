import React, { useState, useEffect } from 'react';
import { Button, Container, Typography, Paper, Grid } from '@mui/material';

const QuizPage = () => {
  const [questionData, setQuestionData] = useState(null);

  useEffect(() => {
    // Fetch question data from your API here
    // Example API call using fetch:
    fetch('https://quiz-web-app-five.vercel.app/questions')
      .then((response) => response.json())
      .then((data) => setQuestionData(data))
      .catch((error) => console.error('Error fetching data:', error));
  }, []); // Empty dependency array ensures the effect runs once on component mount

  const handleAnswer = (selectedOption, optionContent) => {
    // Check if the selected option is correct
    const isCorrect = optionContent === questionData.correct_answer;
    //console.log('Selecte d option:', selectedOption);
    //console.log('Correct answer:', questionData.correct_answer);

    // Log the content of the selected option
   // console.log('Selected option content:', optionContent);

    // You can update the UI based on whether the answer is correct or not
    if (isCorrect) {
      // Handle the correct answer, e.g., show a success message, update score, etc.
      console.log('Correct answer!');
    } else {
      // Handle the incorrect answer, e.g., show an error message, provide correct answer, etc.
      console.log('Incorrect answer. The correct answer is:', questionData.correct_answer);
    }

    // You can implement logic here to move to the next question or navigate to a result page
    // For simplicity, let's fetch a new question after a brief delay
    setTimeout(() => {
      // Fetch the next question from your API and update questionData
      // Replace the following fetch example with your actual API endpoint
      fetch('https://quiz-web-app-five.vercel.app/questions')
        .then((response) => response.json())
        .then((data) => setQuestionData(data))
        .catch((error) => console.error('Error fetching data:', error));
    }, 1000); // Delay for 1 second (adjust as needed)
  };

  const background = {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    height: '100vh',
    background: 'linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%',
    };

  return (
    <div style={background}>
        <Container style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', height: '100vh' }}>
        <Paper
            elevation={3}
            style={{
            padding: '40px',
            maxWidth: '600px',
            position: 'relative',
            }}
        >
            {questionData ? (
            <>
                <Typography variant="h5" align="center" gutterBottom>
                {questionData.question}
                </Typography>
                <Grid container spacing={2}>
                {['A', 'B', 'C', 'D'].map((option, index) => (
                    <Grid item xs={6} key={index}>
                    <Button
                        variant="contained"
                        color="primary"
                        fullWidth
                        onClick={() => handleAnswer(`option${option}`, questionData[`option${option}`])}
                    >
                        {questionData[`option${option}`]}
                    </Button>
                    </Grid>
                ))}
                </Grid>
            </>
            ) : (
            <Typography variant="h6" align="center">
                Loading...
            </Typography>
            )}
        </Paper>
        </Container>
    </div>
  );
};

export default QuizPage;
