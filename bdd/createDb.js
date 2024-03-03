// createDb.js

const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('quiz.db');

// Création de la table 'questions'
db.run(`
  CREATE TABLE IF NOT EXISTS questions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    question_text TEXT NOT NULL,
    options TEXT NOT NULL,
    correct_option INTEGER NOT NULL
  )
`);

// Insertion de quelques questions
const questions = [
  {
    question_text: 'Quelle est la capitale de la France ?',
    options: '["Londres", "Berlin", "Paris", "Madrid"]',
    correct_option: 2,
  },
  {
    question_text: 'Quel est le plus grand océan du monde ?',
    options: '["Atlantique", "Arctique", "Indien", "Pacifique"]',
    correct_option: 3,
  },
  // Ajoutez d'autres questions selon le même format
];

// Insertion des questions dans la base de données
questions.forEach((question) => {
  db.run(
    'INSERT INTO questions (question_text, options, correct_option) VALUES (?, ?, ?)',
    [question.question_text, question.options, question.correct_option],
    (err) => {
      if (err) {
        console.error(err.message);
      }
    }
  );
});

// Fermeture de la connexion à la base de données
db.close();
