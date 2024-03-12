// App.js

import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import IndexComponent from './page/IndexComponent';
import ClassementComponent from "./page/ClassementComponent";
import LoginComponent from "./page/LoginComponent";
import RegisterComponent from "./page/RegisterComponent";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      questions: [],
      currentQuestionIndex: 0,
      userAnswers: [],
    };
  }

  componentDidMount() {
    // Effectuer une requête à votre API pour récupérer les questions
    fetch('https://quiz-web-app-five.vercel.app/api/questions')
      .then(response => response.json())
      .then(data => {
        this.setState({ questions: data });
      })
      .catch(error => console.error('Erreur lors de la récupération des questions', error));
  }

  render() {
    const { questions, currentQuestionIndex } = this.state;
  
    if (questions.length === 0) {
      return <p>Chargement des questions...</p>;
    }
  
    const currentQuestion = questions[currentQuestionIndex];
  
    // Extract options from individual properties
    const options = [currentQuestion.optiona, currentQuestion.optionb, currentQuestion.optionc, currentQuestion.optiond].filter(Boolean);
  
    // Check if options is an array
    if (!Array.isArray(options) || options.length === 0) {
      console.error('Invalid question data. Options should be an array.', currentQuestion);
      return null; // or handle the error in another way
    }


    
    return (
      <Router>
        <Routes>
          <Route path="/" exact component={IndexComponent} />
          <Route path="/classement" component={ClassementComponent} />
          <Route path="/login" component={LoginComponent} />
          <Route path="/register" component={RegisterComponent} />
          {/* Ajoutez d'autres routes pour les différentes pages */}
        </Routes>
      </Router>
    );

    // return (
    //   <div>
    //     <h1>Quiz App</h1>
    //     <p>{currentQuestion.question}</p>
    //     <ul>
    //       {options.map((option, index) => (
    //         <li key={index}>
    //           <label>
    //             <input
    //               type="radio"
    //               value={option}
    //               onChange={() => this.handleAnswerChange(index)}
    //               checked={index === this.state.userAnswers[currentQuestionIndex]}
    //             />
    //             {option}
    //           </label>
    //         </li>
    //       ))}
    //     </ul>
    //   </div>
    // );
  }
  
  

  handleAnswerChange = (index) => {
    const userAnswers = [...this.state.userAnswers];
    userAnswers[this.state.currentQuestionIndex] = index;
    this.setState({ userAnswers });
  };

  handleNextQuestion = () => {
    this.setState((prevState) => ({
      currentQuestionIndex: prevState.currentQuestionIndex + 1,
    }));
  };
}

export default App;