const { Result } = require('../models/results');

const resultsController = {

    // Get all results
    getResults: async (req, res) => {
        try {
        const results = await Result.findAll();
        res.status(200).json(results);
        } catch (error) {
        console.error(error);
        res.status(500).send('Something went wrong!');
        }
    },


    // Create a new result
    createResult: async (req, res) => {
        try {
        const { iduser, idgame, score } = req.body;
        
        const newResult = await Result.create({ iduser, idgame, score });
        res.status(201).json({ message: 'Result added successfully.' });
        } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
        }
    }
};

module.exports = resultsController;