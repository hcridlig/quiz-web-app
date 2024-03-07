const { DataTypes, Sequelize } = require('sequelize');
const config = require('../config/db');

const sequelize = new Sequelize(config.development);

const Question = sequelize.define('question', {
  idquest: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  question: {
    type: DataTypes.STRING(300),
    allowNull: false,
  },
  optionA: {
    type: DataTypes.STRING(145),
    allowNull: false,
  },
  optionB: {
    type: DataTypes.STRING(118),
    allowNull: false,
  },
  optionC: {
    type: DataTypes.STRING(147),
    allowNull: true,
  },
  optionD: {
    type: DataTypes.STRING(140),
    allowNull: true,
  },
  correct_answer: {
    type: DataTypes.STRING(50),
    allowNull: false,
  },
}, {
  timestamps: false, // Disable createdAt and updatedAt
});


module.exports = {
  sequelize,
  Question,
};
