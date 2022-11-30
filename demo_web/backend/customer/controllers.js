const bcrypt = require('bcrypt');
const { Op } = require('sequelize');
const Customer = require('./model');
const customerService = require('./services');
const baseCRUD = require('../utils/baseCRUD');
const catchAsync = require('../utils/catchAsync');
const { generateToken } = require('../utils/jwt');

exports.getAllCustomers = catchAsync(async (req, res, next) => {
  const name = req.query.name || '';

  const customers = await Customer.findAll({
    where: {
      HoVaTen: {
        [Op.like]: `%${name}%`,
      },
    },
  });

  res.status(200).json({
    count: customers.length,
    customers: customers,
  });
});

exports.getCustomerByID = catchAsync(async (req, res, next) => {
  const customer = await baseCRUD.getOne(Customer, req.params.id);
  res.status(200).json({ customer });
});

exports.createCustomer = catchAsync(async (req, res, next) => {
  const newCustomer = await customerService.createCustomer(req.body);
  res.status(200).json({ customer: newCustomer });
});

exports.deleteCustomerById = catchAsync(async (req, res, next) => {
  const ID = req.params.id;
  await Customer.destroy({
    where: {
      MaKhachHang: ID,
    },
  });

  res.status(204).json({
    status: 'success',
    message: 'Customer is deleted',
  });
});

exports.updateCustomer = catchAsync(async (req, res, next) => {
  const id = req.params.id;

  await Customer.update(req.body, {
    where: { MaKhachHang: id },
    returning: true,
  });

  res.status(200).json({
    status: 'success',
    message: 'Customer is updated',
  });
});

exports.register = catchAsync(async (req, res, next) => {
  const { CCCD, HoVaTen, DienThoai, Email, Username, Password } = req.body;

  if (!Username || !Password) {
    res.status(400).json({
      status: 'fail',
      message: 'Provide enough information!'
    })
  }

  // Check username is used or not
  const hashedPassword = await bcrypt.hash(Password, 12);
  const customer = await customerService.createCustomer({
    CCCD,
    HoVaTen,
    DienThoai,
    Email,
    Username,
    Password: hashedPassword,
  });

  res.status(200).json({
    status: 'success',
    jwt: generateToken(customer.MaKhachHang),
  });
});

exports.login = catchAsync(async (req, res, next) => {
  const { username, password } = req.body;

  const customer = await customerService.getCustomerByUsername(username);
  if (!customer) throw new Error('Customer does not exists')
  const isPasswordMatch = await bcrypt.compare(password, customer.Password);

  if (isPasswordMatch) {
    res.status(200).json({
      status: 'success',
      jwt: generateToken(customer.MaKhachHang),
    });
  }

  res.status(400).json({
    status: 'fail',
    message: 'Username or password is wrong',
  });
});
