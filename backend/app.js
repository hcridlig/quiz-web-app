const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

// Routes
const questionsRoutes = require('./routes/questions');
app.use('/questions', questionsRoutes);

const usersRoutes = require('./routes/users');
app.use('/users', usersRoutes);

const categoriesRoutes = require('./routes/categories');
app.use('/categories', categoriesRoutes);

const resultsRoutes = require('./routes/results');
app.use('/results', resultsRoutes);

const gamesRoutes = require('./routes/games');
app.use('/games', gamesRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something went wrong!');
});

module.exports = app;