const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../db')

const Customer = sequelize.define('Customer', {
  MaKhachHang: {
    type: DataTypes.STRING,
    primaryKey: true
  },
  CCCD: {
    type: DataTypes.STRING,
    allowNull: false
  },
  HoVaTen: {
    type: DataTypes.STRING,
    allowNull: false
  },
  DienThoai: {
    type: DataTypes.STRING
  },
  Email: {
    type: DataTypes.STRING,
    allowNull: false
  },
  Username: {
    type: DataTypes.STRING,
    allowNull: false
  },
  Password: {
    type: DataTypes.STRING,
    allowNull: false
  },
  Diem: {
    type: DataTypes.INTEGER,
    default: 0
  },
  Loai: {
    type: DataTypes.INTEGER,
    default: 0
  }
}, {
  tableName: 'KhachHang',
  timestamps: false
})

module.exports = Customer
