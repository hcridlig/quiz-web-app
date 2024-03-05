const express = require('express');
const router = express.Router();
const questionsController = require('../controllers/questions');

// Define routes for handling questions
router.get('/', questionsController.getRandomQuestion);



/*
app.get('/api/questions', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM Questions ORDER BY RANDOM() LIMIT 1');
      res.json(result.rows);
    } catch (error) {
      console.error('Error executing query', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });*/

module.exports = router;