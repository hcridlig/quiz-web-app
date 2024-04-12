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
};

module.exports = resultsController;