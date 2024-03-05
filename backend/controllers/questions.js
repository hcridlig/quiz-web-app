const { Question, sequelize } = require('../models/questions');

const questionsController = {
    
  getRandomQuestion: async (req, res) => {
    try {
      const randomQuestion = await Question.findOne({
        order: sequelize.random(),
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
};

module.exports = questionsController;
