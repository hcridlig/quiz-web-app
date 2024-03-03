// Ce fichier recupere les question de la BDD

const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('quiz.db');

// Fonction pour récupérer toutes les questions
const getQuestions = () => {
  return new Promise((resolve, reject) => {
    db.all('SELECT * FROM questions', (err, rows) => {
      if (err) {
        reject(err);
      } else {
        resolve(rows);
      }
    });
  });
};

export default { getQuestions };
