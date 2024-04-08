const express = require('express');
const router = express.Router();
const categoriesController = require('../controllers/categories');

router.get('/', categoriesController.getAllCategories);
router.post('/', categoriesController.createCategory);

module.exports = router;