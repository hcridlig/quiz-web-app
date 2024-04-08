const { Category } = require('../models/categories');

const categoriesController = {
    getAllCategories: async (req, res) => {
        try {
          const users = await Category.findAll(
            {
              order: [['title', 'ASC']],
            }
          );
          res.json(users);
        } catch (error) {
          console.error(error);
          res.status(500).send('Internal Server Error');
        }
      },

    createCategory: async (req, res) => {
        try {
          const { title, description, image } = req.body;
          if (!title || !description || !image) {
            return res.status(400).json({ error: 'Veuillez remplir tous les champs.' });
          }
          const newCategory = await Category.create({ title, description, image});
          res.status(201).json({ message: 'Catégorie ajoutée avec succès.' });
        } catch (error) {
          console.error(error);
          res.status(500).send('Internal Server Error');
        }
      },
};

module.exports = categoriesController;
