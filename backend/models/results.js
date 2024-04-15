const { DataTypes, Sequelize } = require('sequelize');
const config = require('../config/db');

const sequelize = new Sequelize(config.development);

const Result = sequelize.define('result', {
  idresult: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  idgame: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  iduser: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  score: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
}, {
  timestamps: false, // Disable createdAt and updatedAt
});

module.exports = {
  sequelize,
  Result,
};
