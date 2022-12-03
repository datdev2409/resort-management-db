const {decodeToken} = require('../utils/jwt')

exports.protect = asyncHandler(async (req, res, next) => {
  const username = decodeToken(req.body.token)
  if (username !== process.env.DB_USERNAME) 
    throw new Error('Authentication failed')

  next();
});
