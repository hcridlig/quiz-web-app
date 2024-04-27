import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import io from 'socket.io-client';
import { Button, Container, Typography, Paper, Grid } from '@mui/material';

const QuizPage = () => {
  const apiUrl = process.env.REACT_APP_API_URL;
  const navigate = useNavigate();
  const location = useLocation();
  const socket = window.socket;
  const roomId = location.state.roomId;
  const playerName = localStorage.getItem('playerName');
  const [questionData, setQuestionData] = useState(null);
  const [answerSelected, setAnswerSelected] = useState(false);
  const [score, setScore] = useState(0);
  const [timeLeft, setTimeLeft] = useState(null); 
  const [quizEnded, setQuizEnded] = useState(false); // State to track if quiz has ended

  useEffect(() => {
    let timer = null;
  
    const handleGame = (data) => {
      setQuestionData(data);
      setAnswerSelected(false);
      resetButtonColors();
  
      clearInterval(timer); // Clear any existing interval before starting a new one
      setTimeLeft(10);
      timer = setInterval(() => {
        setTimeLeft((prevTime) => prevTime - 1);
      }, 1000);
    };
  
    const handleAnswerResult = ({ score, selectedAnswer, correctAnswer }) => {
      setScore(score);
      const isCorrect = selectedAnswer === correctAnswer;
  
      const buttons = document.querySelectorAll('.quiz-button');
  
      if (isCorrect) {
        buttons.forEach((button) => {
          if (button.textContent === selectedAnswer) {
            button.style.backgroundColor = '#4caf50'; 
          }
        });
      } else {
        buttons.forEach((button) => {
          if (button.textContent === selectedAnswer) {
            button.style.backgroundColor = '#f44336'; 
          } else if (button.textContent === correctAnswer) {
            button.style.backgroundColor = '#4caf50'; 
          }
        });
      }
    };
  
    const handleEnd = () => {
      setQuizEnded(true); // Set quiz ended to true
      clearInterval(timer); // Clear the timer
      setTimeLeft(0); // Set time left to 0
      setTimeout(() => {
        navigate('/result', {state: {roomId : roomId}}); // Redirect to results page after a few seconds
      }, 5000); // Adjust the delay time as needed
    };
  
    socket.on('game', handleGame);
    socket.on('answerResult', handleAnswerResult);
    socket.on('end', handleEnd); // Handle the 'end' event
  
    return () => {
      socket.off('game', handleGame);
      socket.off('answerResult', handleAnswerResult);
      socket.off('end', handleEnd); // Remove the 'end' event listener
      clearInterval(timer); // Clear the timer when the component unmounts
    };
  }, []);

  const handleAnswer = (selectedOption, optionContent) => {
    if (!answerSelected) {
      socket.emit('answer', roomId, playerName, optionContent);
      setAnswerSelected(true);
    }
  };

  const resetButtonColors = () => {
    const buttons = document.querySelectorAll('.quiz-button');
    buttons.forEach((button) => {
      button.style.backgroundColor = ''; 
    });
  };

  const background = {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    height: '100vh',
    background: 'linear-gradient(45deg, #FE6B8B 30%, #FF8E53 90%',
  };

  return (
    <div>
      {quizEnded && (
        <div
          style={{
            position: 'fixed',
            top: '10%', // Adjust top position as needed
            left: '50%',
            transform: 'translateX(-50%)',
            backgroundColor: 'rgba(255, 255, 255, 0.9)',
            padding: '20px',
            borderRadius: '8px',
            zIndex: '999',
          }}
        >
          <Typography variant="h6" align="center">
            Quiz Terminé!
          </Typography>
          <Typography variant="h6" align="center">
            Redirection vers les résultats...
          </Typography>
        </div>
      )}
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
            <Typography variant="h6" align="center" gutterBottom>
              Score: {score}
            </Typography>
            {questionData ? (
              <>
                <Typography variant="h5" align="center" gutterBottom>
                  {questionData.question}
                </Typography>
                {quizEnded ? null : (
                  <Typography variant="h6" align="center" gutterBottom>
                    Time left: {timeLeft}
                  </Typography>
                )}
                <Grid container spacing={2}>
                  {['A', 'B', 'C', 'D'].map((option, index) => (
                    <Grid item xs={6} key={index}>
                      <Button
                        className="quiz-button"
                        variant="contained"
                        color="primary"
                        fullWidth
                        disabled={answerSelected || quizEnded} // Disable buttons if answer has been selected or quiz has ended
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
    </div>
  );
};

export default QuizPage;
