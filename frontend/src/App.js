// App.js

import React, { Component } from 'react';

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
    fetch('votre_api/questions')
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

    return (
      <div>
        <h1>Quiz App</h1>
        <p>{currentQuestion.question}</p>
        <ul>
          {currentQuestion.options.map((option, index) => (
            <li key={index}>
              <label>
                <input
                  type="radio"
                  value={option}
                  onChange={() => this.handleAnswerChange(index)}
                  checked={index === this.state.userAnswers[currentQuestionIndex]}
                />
                {option}
              </label>
            </li>
          ))}
        </ul>
        <button onClick={this.handleNextQuestion}>Suivant</button>
      </div>
    );
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
