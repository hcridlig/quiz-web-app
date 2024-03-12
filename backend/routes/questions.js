const express = require('express');
const router = express.Router();
const questionsController = require('../controllers/questions');

// Define routes for handling questions
router.get('/', questionsController.getRandomQuestion);

module.exports = router;