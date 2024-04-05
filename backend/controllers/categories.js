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
};

module.exports = categoriesController;
