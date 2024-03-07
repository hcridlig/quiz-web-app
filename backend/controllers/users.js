const { User } = require('../models/users');

const usersController = {
  getAllUsers: async (req, res) => {
    try {
      const users = await User.findAll();
      res.json(users);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },

  getUserById: async (req, res) => {
    try {
      const user = await User.findByPk(req.params.id);
      if (!user) {
        return res.status(404).json({ error: 'User not found.' });
      }
      res.json(user);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },

  createUser: async (req, res) => {
    try {
      const newUser = await User.create(req.body);
      res.status(201).json(newUser);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },

  updateUser: async (req, res) => {
    try {
      const [updatedRowsCount] = await User.update(req.body, {
        where: { iduser: req.params.id },
        returning: true,
      });
  
      if (updatedRowsCount === 0) {
        return res.status(404).json({ error: 'User not found.' });
      }
  
      // Fetch the updated user after the update
      const updatedUser = await User.findByPk(req.params.id);
  
      // Send the updated user as a response
      res.json(updatedUser);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },
  

  deleteUser: async (req, res) => {
    try {
      const deletedRowCount = await User.destroy({ where: { iduser: req.params.id } });

      if (deletedRowCount === 0) {
        return res.status(404).json({ error: 'User not found.' });
      }

      res.json({ message: 'User deleted successfully.' });
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },
};

module.exports = usersController;
