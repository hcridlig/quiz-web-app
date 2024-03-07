const { DataTypes, Sequelize } = require('sequelize');
const config = require('../config/db');

const sequelize = new Sequelize(config.development);

const User = sequelize.define('user', {
  iduser: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  username: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: true,
  },
  email: {
    type: DataTypes.STRING(100),
    allowNull: false,
    unique: true,
    validate: {
      isEmail: true,
    },
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
  },
}, {
  timestamps: false, // Disable createdAt and updatedAt
});

module.exports = User;


module.exports = {
  sequelize,
  User,
};
