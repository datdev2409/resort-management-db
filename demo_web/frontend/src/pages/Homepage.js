import axios from 'axios';
import { useEffect, useState } from 'react';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';

function Homepage() {
  const URL = 'http://localhost:3000/customer';
  const [customers, setCustomers] = useState([]);
  useEffect(() => {
    async function getData() {
      const res = await axios.get(URL);
      return res.data.customers;
    }

    getData().then((customers) => setCustomers(customers));
  });

  const deleteCustomer = async (id) => {
    const URL = `http://localhost:3000/customer/${id}`;
    const res = await axios.delete(URL);
    console.log(res);
  };

  const updateCustomer = async (id) => {
    console.log(id);
  };

  return (
    <div className="mt-2 container">
      <div className='mb-3 d-flex justify-content-between'>
        <h3>Customer Management</h3>
        <Button variant='success'>Add new customer</Button>
      </div>
      <Table striped bordered hover>
        <thead>
          <tr>
            <th>Ma Khach Hang</th>
            <th>CMND/CCCD</th>
            <th>Ho va ten</th>
            <th>Dien thoai</th>
            <th>Email</th>
            <th>Username</th>
            <th>Score</th>
            <th>Type</th>
            <th>Action</th>
          </tr>
        </thead>

        <tbody>
          {customers.map((customer, index) => {
            return (
              <tr key={index}>
                <td className='align-middle text-center'>{customer.MaKhachHang}</td>
                <td className='align-middle'>{customer.CCCD}</td>
                <td className='align-middle'>{customer.HoVaTen}</td>
                <td className='align-middle'>{customer.DienThoai}</td>
                <td className='align-middle'>{customer.Email}</td>
                <td className='align-middle'>{customer.Username}</td>
                <td className='align-middle text-center'>{customer.Diem}</td>
                <td className='align-middle text-center'>{customer.Loai}</td>
                <td className='align-middle'>
                  <Button
                    className="m-1"
                    onClick={() => deleteCustomer(customer.MaKhachHang)}
                    variant="danger"
                    size="sm">
                    Delete
                  </Button>
                  <Button
                    onClick={() => updateCustomer(customer.MaKhachHang)}
                    variant="primary"
                    size="sm">
                    Update
                  </Button>
                </td>
              </tr>
            );
          })}
        </tbody>
      </Table>
    </div>
  );
}

export default Homepage;
