//create express app
const express = require('express');
const pool = require('./db'); // Import the database connection
const cors = require('cors');


const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors());

app.get('/', (req, res) => {
    res.send('Hello World denn,dedefrom express');
});

app.get('/api/questions', async (req, res) => {
    try {
      const result = await pool.query('SELECT * FROM Questions ORDER BY RANDOM() LIMIT 1');
      res.json(result.rows);
    } catch (error) {
      console.error('Error executing query', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });