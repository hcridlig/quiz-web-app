const { Game } = require('../models/games');

const categoriesController = {
    createGame: async (req, res) => {
        try {
            const { start_time, idcat, roomid } = req.body;
            if (!start_time || !idcat || !roomid) {
                return res.status(400).json({ error: 'Veuillez remplir tous les champs.' });
            }
            const newGame = await Game.create({ start_time, idcat, roomid });
            res.status(201).json({ message: 'Partie ajoutée avec succès.' });
        } catch (error) {
            console.error(error);
            res.status(500).send('Internal Server Error');
        }
    },

    updateEndTime: async (req, res) => {
        try {
            console.log('updateEndTime');
            const { roomid } = req.params;
            const { end_time } = req.body;

            if (!end_time) {
                return res.status(400).json({ error: 'Veuillez fournir une heure de fin.' });
            }

            const game = await Game.findOne({ where: { roomid } });

            if (!game) {
                return res.status(404).json({ error: 'Partie non trouvée.' });
            }

            await game.update({ end_time });

            return res.status(200).json({ message: 'Heure de fin mise à jour avec succès.' });
        } catch (error) {
            console.error(error);
            return res.status(500).send('Internal Server Error');
        }
    },

    getGameId: async (req, res) => {
        try {
            const { roomid } = req.params;
            const game = await Game.findOne({ where: { roomid } });

            if (!game) {
                return res.status(404).json({ error: 'Partie non trouvée.' });
            }

            return res.status(200).json(game);
        } catch (error) {
            console.error(error);
            return res.status(500).send('Internal Server Error');
        }
    }
    

};

module.exports = categoriesController;
