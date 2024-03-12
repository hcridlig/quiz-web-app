import React, { useState, useEffect } from 'react';
import { Button, Container, Typography, Paper, Grid } from '@mui/material';

const QuizPage = () => {
  const [questionData, setQuestionData] = useState(null);
  const [answerSelected, setAnswerSelected] = useState(false);

  useEffect(() => {
    // Fetch question data from your API here
    fetch('https://quiz-web-app-five.vercel.app/questions')
      .then((response) => response.json())
      .then((data) => setQuestionData(data))
      .catch((error) => console.error('Error fetching data:', error));
  }, []);

  const handleAnswer = (selectedOption, optionContent) => {
    if (!answerSelected) {
      // Check if the selected option is correct
      const isCorrect = optionContent === questionData.correct_answer;
  
      const buttons = document.querySelectorAll('.quiz-button');
      buttons.forEach((button) => {
        if (button.textContent === optionContent) {
          if (isCorrect) {
            button.style.backgroundColor = '#4caf50';
          } else {
            setTimeout(() => {
              buttons.forEach((btn) => {
                if (btn.textContent === questionData.correct_answer) {
                  btn.style.backgroundColor = '#4caf50';
                }
              });
            }, 600);
            button.style.backgroundColor = '#f44336';
          }
        }
      });  
     
      setTimeout(() => {
        fetch('https://quiz-web-app-five.vercel.app/questions')
          .then((response) => response.json())
          .then((data) => {
            setQuestionData(data);
            setAnswerSelected(false);
            buttons.forEach((button) => {
              button.style.backgroundColor = '';
            });
          })
          .catch((error) => console.error('Error fetching data:', error));
      }, 1200);
  
      setAnswerSelected(true);
    }
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
                      className="quiz-button"
                      variant="contained"
                      color="primary"
                      fullWidth
                      disabled={answerSelected}
                      onClick={() => handleAnswer(`option${option}`, questionData[`option${option}`])}
                      sx={{
                        '&.Mui-disabled': {
                          backgroundColor: 'primary.main',
                          color: 'primary.contrastText',
                        },
                      }}
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
