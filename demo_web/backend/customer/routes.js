const express = require('express');
const router = express.Router();
const {
  getAllCustomers,
  getCustomerByID,
  createCustomer,
  deleteCustomerById,
  updateCustomer,
  register,
  login,
} = require('./controllers');

router.get('/', getAllCustomers);
router.post('/', createCustomer);

router.post('/register', register)
router.post('/login', login)

router.get('/:id', getCustomerByID);
router.delete('/:id', deleteCustomerById);
router.patch('/:id', updateCustomer)

module.exports = router;
