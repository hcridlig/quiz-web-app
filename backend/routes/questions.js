const express = require('express');
const router = express.Router();
const questionsController = require('../controllers/questions');

// Define routes for handling questions
router.get('/:idcat', questionsController.getRandomQuestion);
router.post('/', questionsController.addQuestion);

module.exports = router;