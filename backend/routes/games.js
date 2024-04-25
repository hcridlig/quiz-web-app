const express = require('express');
const router = express.Router();
const gamesController = require('../controllers/games');

// Define routes for handling questions
router.post('/create', gamesController.createGame);
router.put('/update/:roomid', gamesController.updateEndTime);
router.get('/:roomid', gamesController.getGameId);

module.exports = router;