import React, { useState } from 'react';
import Question from './Question';

const Quiz = ({ questions }) => {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [score, setScore] = useState(0);

  const handleAnswer = (selectedOption) => {
    const correctAnswer = questions[currentQuestion].correctAnswer;

    // Logique pour vérifier si la réponse est correcte
    if (selectedOption === correctAnswer) {
      // Si la réponse est correcte, mettre à jour le score
      setScore(score + 1);
    }

    // Passer à la question suivante
    setCurrentQuestion(currentQuestion + 1);
  };

  return (
    <div>
      {currentQuestion < questions.length ? (
        <Question
          question={questions[currentQuestion].question}
          options={questions[currentQuestion].options}
          handleAnswer={handleAnswer}
        />
      ) : (
        <div>
          <h2>Quiz terminé ! Votre score : {score}</h2>
        </div>
      )}
    </div>
  );
};

export default Quiz;
