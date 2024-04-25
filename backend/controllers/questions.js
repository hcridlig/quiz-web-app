const { Question, sequelize } = require('../models/questions');
const jwt = require('jsonwebtoken');

const questionsController = {
    
  getRandomQuestion: async (req, res) => {
    try {
      const randomQuestion = await Question.findAll({
        order: sequelize.random(),
        limit: 3,
        where: {
          idcat: req.params.idcat,
        },
      });

      if (!randomQuestion) {
        return res.status(404).json({ error: 'No questions available.' });
      }

      res.json(randomQuestion);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },

  addQuestion: async (req, res) => {
    try {
      // Extract token from the Authorization header
      const authHeader = req.headers['authorization'];
      const token = authHeader && authHeader.split(' ')[1];
  
      if (!token) {
        return res.status(401).json({ error: 'No token provided.' });
      }
  
      // Verify the token
      const decodedToken = jwt.verify(token, process.env.API_SECRET_KEY);
  
      // Check if the user has the required role
      if (decodedToken.role !== true) {
        return res.status(401).json({ error: 'Unauthorized.' });
      }
  
      const { title, option1, option2, option3, option4, correctAnswer, category } = req.body;
  
      if (!title || !option1 || !option2 || !option3 || !option4 || !correctAnswer || !category) {
        return res.status(400).json({ error: 'Veuillez remplir tous les champs.' });
      }
  
      const newQuestion = await Question.create({
        question: title,
        optionA: option1,
        optionB: option2,
        optionC: option3,
        optionD: option4,
        correct_answer: correctAnswer,
        idcat: category,
      });
  
      res.status(201).json({message: "Question ajoutée avec succès."});
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },  
};

module.exports = questionsController;
