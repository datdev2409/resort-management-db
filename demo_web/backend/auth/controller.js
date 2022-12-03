const connectDB = require("../db");
const catchAsync = require("../utils/catchAsync");

exports.login = catchAsync(async (req, res, next) => {
  const {username, password} = req.body;
  const sequelize = await connectDB(username, password)
})
