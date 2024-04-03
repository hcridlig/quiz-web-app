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

  getPlayerName: async(req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
  
    if (!token) {
      return res.status(401).send('Token not found');
    }
  
    try {
      const decoded = jwt.verify(token, process.env.API_SECRET_KEY); // Verify token using secret key
      const playerName = decoded.username;
      res.json({ playerName });
    } catch (err) {
      return res.status(401).send('Invalid token');
    }
  },

  getUserById: async (req, res) => {
    try {
      const user = await User.findByPk(req.params.id, {
        attributes: ['iduser', 'username', 'email']
      });
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
      res.status(400).json({ error: 'Email ou mot de passe incorrect'});
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
        const token = jwt.sign({ userId: user.id, username: user.username }, process.env.API_SECRET_KEY, { expiresIn: '1w' });
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
      const { currentPassword, newPassword, ...updateData } = req.body;
  
      // Find the user
      const user = await User.findByPk(req.params.id);
      if (!user) {
        return res.status(404).json({ error: 'User not found.' });
      }
  
      // If newPassword is provided, require currentPassword
      if (newPassword || req.body.password ) {
        if (!currentPassword) {
          return res.status(400).json({ error: 'Current password is required.' });
        }
        
        const isPasswordValid = await bcrypt.compare(currentPassword, user.password);
        if (!isPasswordValid) {
          return res.status(400).json({ error: 'Current password is incorrect.' });
        }
        
        // Hash the new password
        const hashedPassword = await bcrypt.hash(newPassword, saltRounds);
        updateData.password = hashedPassword; // Include the new hashed password in the updateData
      }
  
      // Update user data
      const [updatedRowsCount] = await User.update(
        updateData, // Use updateData which may include the new hashed password
        {
          where: { iduser: req.params.id },
          returning: true,
        }
      );
  
      if (updatedRowsCount === 0) {
        return res.status(404).json({ error: 'User not found.' });
      }
  
      // Fetch the updated user after the update
      const updatedUser = await User.findByPk(req.params.id, {
        attributes: ['iduser', 'username', 'email']
      });
  
      // Generate a new JWT token for the user
      const token = jwt.sign({ id: updatedUser.iduser, username: updatedUser.username }, process.env.API_SECRET_KEY, { expiresIn: '1w' });

      // Respond with updated user data and token
      return res.json({ user: updatedUser, token });
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
