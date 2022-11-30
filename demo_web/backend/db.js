const {Sequelize} = require('sequelize')

const DB = 'RESORT'
const username = 'admin'
const password = '240902'

const sequelize = new Sequelize(DB, username, password, {
  host: 'localhost',
  dialect: 'mysql'
})

module.exports = sequelize
