const cors = require('cors')
const dotenv = require('dotenv')
const express = require('express')

const sequelize = require('./db')
const customerRouter = require('./customer/routes')

const app = express()
dotenv.config()

app.use(cors())
app.use(express.json())
app.use(express.urlencoded({extended: true}))

sequelize.authenticate()
  .then(() => console.log('DB is connected'))
  .catch(console.error)

app.use('/customer', customerRouter)

// ERROR HANDLER
app.use((err, req, res, next) => {
  console.error(err)
  res.status(500).json({
    error: err.message
  })
})

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})
