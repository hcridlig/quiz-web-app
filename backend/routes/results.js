const express = require('express');
const router = express.Router();
const resultsController = require('../controllers/results');

// Define routes for handling questions
router.get('/', resultsController.getResults);

module.exports = router;