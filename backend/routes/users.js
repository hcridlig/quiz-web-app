const express = require('express');
const router = express.Router();
const usersController = require('../controllers/users');

router.get('/all', usersController.getAllUsers);
router.get('/:id', usersController.getUserById);
router.post('/', usersController.createUser);
router.post('/signin', usersController.signIn);
router.put('/:id', usersController.updateUser);
router.delete('/:id', usersController.deleteUser);

module.exports = router;