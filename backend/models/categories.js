const { DataTypes, Sequelize } = require('sequelize');
const config = require('../config/db');

const sequelize = new Sequelize(config.development);

const Category = sequelize.define('category', {
  idcat: {
    type: DataTypes.INTEGER,
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  description: {
    type: DataTypes.TEXT,
    allowNull: true,
  },
  image: {
    type: DataTypes.STRING,
    allowNull: true,
  },
}, {
    timestamps: false,
});

module.exports = {
    sequelize,
    Category,
};
