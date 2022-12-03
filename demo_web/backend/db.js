const dotenv = require('dotenv')
const {Sequelize} = require('sequelize')

dotenv.config()

const DB = process.env.DB || 'RESORT'
const username = process.env.DB_USERNAME || 'admin'
const password = process.env.DB_PASSWORD || '240902'

console.log(username, password)

const sequelize = new Sequelize(DB, username, password, {
  host: 'localhost',
  dialect: 'mysql'
})

module.exports = sequelize
