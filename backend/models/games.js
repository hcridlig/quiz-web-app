const { DataTypes, Sequelize } = require('sequelize');
const config = require('../config/db');

const sequelize = new Sequelize(config.development);

const Game = sequelize.define('game', {
  idgame: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  },
  start_time: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  end_time: {
    type: DataTypes.DATE,
    allowNull: true,
    defaultValue: null,
  },
  idcat: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  roomid: {
    type: DataTypes.CHAR(4),
    allowNull: false,
  },
}, {
  timestamps: false, // Disable createdAt and updatedAt
});

module.exports = {
  sequelize,
  Game,
};
