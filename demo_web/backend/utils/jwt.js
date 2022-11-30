const jwt = require('jsonwebtoken');

exports.generateToken = (id) => {
  const privateKey = process.env.JWT_SECRET;
  const expiresIn = process.env.JWT_EXPIRES_IN;
  const token = jwt.sign({ id }, privateKey, { expiresIn });
  return token;
};

exports.decodeToken = (token) => {
  const { JWT_SECRET } = process.env;
  return new Promise((resolve, reject) => {
    jwt.verify(token, JWT_SECRET, (err, decoded) => {
      if (err) reject(err);
      resolve(decoded);
    });
  });
};
