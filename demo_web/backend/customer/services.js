const Customer = require('./model')

exports.getCustomerByEmail = async (email) => {
  const customer = await Customer.findOne({
    where: { Email: email }
  }) 
  return customer;
}

exports.getCustomerByUsername = async (username) => {
  const customer = await Customer.findOne({
    where: { Username: username }
  }) 
  return customer;
}

exports.createCustomer = async (customerObj) => {
  const customer = await Customer.create(customerObj);
  return customer;
}
