const { User } = require('../models/users');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const saltRounds = 10; 

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
      const hashedPassword = await bcrypt.hash(req.body.password, saltRounds);

      //const newUser = await User.create(req.body);
      const newUser = await User.create({
        email: req.body.email,
        username: req.body.username,
        password: hashedPassword,
      });
      res.status(200).json(newUser);
    } catch (error) {
      //console.log('Error during user creation:', error);
      res.status(400).json({ error: 'Email or username already in use' });
    }
  },
  
  signIn: async (req, res) => {
    const { email, password } = req.body;
  
    try {
      // Find the user by email
      const user = await User.findOne({ where: { email } });
  
      // Check if the user exists
      if (!user) {
        return res.status(401).json({ error: 'Invalid email or password' });
      }
  
      // Compare the provided password with the hashed password in the database
      const passwordMatch = await bcrypt.compare(password, user.password);
  
      // If passwords match, generate a JWT token and send it in the response
      if (passwordMatch) {
        const token = jwt.sign({ userId: user.id }, process.env.API_SECRET_KEY, { expiresIn: '1w' }); // Update with your secret key
        return res.json({ token });
      } else {
        return res.status(401).json({ error: 'Invalid email or password' });
      }
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal Server Error' });
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
