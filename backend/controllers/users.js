const { User } = require('../models/users');
const { Op } = require('sequelize');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const saltRounds = 10; 

const usersController = {
  getAllUsers: async (req, res) => {
    try {
      const users = await User.findAll({
        order: [['username', 'ASC']], 
        attributes: { exclude: ['password'] },
      });

      res.json(users);
    } catch (error) {
      console.error(error);
      res.status(500).send('Internal Server Error');
    }
  },
  

  getPlayerInfos: async(req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
  
    if (!token) {
      return res.status(401).send('Token not found');
    }
  
    try {
      const decoded = jwt.verify(token, process.env.API_SECRET_KEY); // Verify token using secret key
      const playerId = decoded.userId;
      const playerName = decoded.username;
      const playerRole = decoded.role;
      res.json({playerId, playerName, playerRole });
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
      // Check if email or username already exists
      const existingUser = await User.findOne({
        where: {
          [Op.or]: [
            { email: req.body.email },
            { username: req.body.username }
          ]
        }
      });
      console.log('existingUser:', existingUser);
      if (existingUser) {
        return res.status(400).json({ error: "Email or username already in use" });
      }
  
      const hashedPassword = await bcrypt.hash(req.body.password, saltRounds);
  
      const newUser = await User.create({
        email: req.body.email,
        username: req.body.username,
        password: hashedPassword,
        role: false,
      });
  
      res.status(200).json(newUser);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  },
  
  
  signIn: async (req, res) => {
    const { email, password } = req.body;
  
    try {
      // Find the user by email
      const user = await User.findOne({ where: { email } });
  
      // Check if the user exists
      if (!user) {
        return res.status(401).json({ error: 'Email ou mot de passe incorrect' });
      }
  
      // Compare the provided password with the hashed password in the database
      const passwordMatch = await bcrypt.compare(password, user.password);
  
      // If passwords match, generate a JWT token and send it in the response
      if (passwordMatch) {
        const token = jwt.sign({ userId: user.iduser, username: user.username, role: user.role }, process.env.API_SECRET_KEY, { expiresIn: '1w' });
        return res.json({ token });
      } else {
        return res.status(401).json({ error: 'Email ou mot de passe incorrect' });
      }
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal Server Error' });
    }
  },

  updateUser: async (req, res) => {
    try {
      const { currentPassword, newPassword, page, ...updateData } = req.body;
      const authHeader = req.headers['authorization'];
      const token = authHeader && authHeader.split(' ')[1];
  
      if (!token) {
        return res.status(401).json({ error: 'Authorization token is missing.' });
      }
  
      // Verify the token
      jwt.verify(token, process.env.API_SECRET_KEY, async (err, decoded) => {
        if (err) {
          return res.status(401).json({ error: 'Invalid token.'});
        }
        
        // Extract role from decoded token
        const isAdmin = decoded.role;
  
        // Find the user
        const user = await User.findByPk(req.params.id);
        if (!user) {
          return res.status(404).json({ error: 'User not found.' });
        }
  
        // Check the page value and perform different validations
        if (page === 'editUser') {
          if((!currentPassword && newPassword) || (currentPassword && !newPassword)) {
            return res.status(401).json({ error: 'Veuillez saissir votre mot de passe actuel.'});
          }

          // If the user is not an admin and is trying to edit another user's data, return an error
          if (!isAdmin && user.iduser !== decoded.userId) {
            return res.status(403).json({ error: 'Forbidden. You can only edit your own data.' });
          }

          console.log('updateData:', updateData);
          // If the user is trying to change their password, verify the current password
          if (currentPassword) {
            const passwordMatch = await bcrypt.compare(currentPassword, user.password);
            if (!passwordMatch) {
              return res.status(401).json({ error: 'Mot de passe incorrect.' });
            }
          }
          const hashedPassword = await bcrypt.hash(newPassword, saltRounds);
          updateData.password = hashedPassword; // Include the new hashed password in the updateData
        } else if (page === 'userManagement') {
          // If the user is not an admin, return an error
          if (!isAdmin) {
            return res.status(403).json({ error: 'Forbidden. Only admins can perform this action.' });
          }
  
          // If newPassword is provided, hash the new password
          if (newPassword) {
            const hashedPassword = await bcrypt.hash(newPassword, saltRounds);
            updateData.password = hashedPassword; // Include the new hashed password in the updateData
          }
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
  
        // Only generate a new JWT token if the user updated their own password
        if (page === 'editUser') {
          const newToken = jwt.sign({ userId: updatedUser.iduser, username: updatedUser.username, role: isAdmin }, process.env.API_SECRET_KEY, { expiresIn: '1w' });
          return res.json({ user: updatedUser, token: newToken });
        }
  
        // Respond with updated user data only
        return res.json({ user: updatedUser });
      });
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
