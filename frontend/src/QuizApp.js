//Ce fichier est le point d'entrée de votre application.
//C'est là que vous initialiserez l'état, effectuerez la récupération des questions, et organiserez la logique globale de votre application.

// QuizApp.js
import React, { useState, useEffect } from 'react';
import QuizDataService from '../services/QuizDataService';
import Question from '../components/Question';
import Options from '../components/Options';
import Result from '../components/Result';

const QuizApp = () => {
  const [questions, setQuestions] = useState([]);
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [selectedOptions, setSelectedOptions] = useState([]);
  const [score, setScore] = useState(0);
  const [quizCompleted, setQuizCompleted] = useState(false);

  useEffect(() => {
    const fetchQuestions = async () => {
      try {
        const response = await QuizDataService.getQuestions();
        setQuestions(response.data);
      } catch (error) {
        console.error('Erreur lors de la récupération des questions :', error);
      }
    };

    fetchQuestions();
  }, []);

  const handleOptionSelect = (selectedOption) => {
    // Logique pour gérer la sélection des options
    // Cette fonction doit probablement mettre à jour l'état des réponses sélectionnées (selectedOptions)
  };

  const goToNextQuestion = () => {
    // Logique pour passer à la question suivante
    // Cette fonction doit probablement mettre à jour l'état pour passer à la prochaine question (setCurrentQuestion)
    setCurrentQuestion(prevQuestion => prevQuestion + 1);
  };

  const showResults = () => {
    // Logique pour afficher les résultats
    // Cette fonction doit probablement calculer le score final en fonction des réponses sélectionnées (selectedOptions)
    // et mettre à jour l'état pour indiquer que le quiz est terminé (setQuizCompleted)
  };

  return (
    <div className="quiz-app">
      {quizCompleted ? (
        <Result score={score} />
      ) : (
        <>
          <Question question={questions[currentQuestion]} />
          <Options
            options={questions[currentQuestion].options}
            onOptionSelect={handleOptionSelect}
          />
          <button onClick={goToNextQuestion}>Question suivante</button>
        </>
      )}
    </div>
  );
};

export default QuizApp;

