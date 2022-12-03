import React from 'react';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import axios from 'axios'

function RegisterPage() {
  const submitURL = 'http://localhost:3000/customer/register'

  const handleSubmit = async (e) => {
    e.preventDefault()

    const CCCD = e.target.CCCD.value
    const HoVaTen = e.target.HoVaTen.value
    const DienThoai = e.target.DienThoai.value
    const Email = e.target.Email.value
    const Username = e.target.Username.value
    const Password = e.target.Password.value

    const res = await axios.post(submitURL, {
      CCCD, HoVaTen, DienThoai, Email, Username, Password 
    })

    console.log(res)
  }

  return (
    <div className='d-flex justify-content-center align-items-center'> 
      <Form onSubmit={handleSubmit} className='mt-3 border border-3 p-4 rounded' style={{width: '600px'}}>
        <h3>Register</h3>
        <Form.Group className="mb-2" controlId="CCCD">
          <Form.Label>CMND/CCCD</Form.Label>
          <Form.Control name="CCCD" type="text" placeholder="CMND/CCCD" />
        </Form.Group>
        <Form.Group className="mb-2" controlId="Fullname">
          <Form.Label>Fullname</Form.Label>
          <Form.Control name="HoVaTen" type="text" placeholder="Fullname" />
        </Form.Group>
        <Form.Group className="mb-2" controlId="Phone number">
          <Form.Label>Phone number</Form.Label>
          <Form.Control name="DienThoai" type="text" placeholder="Phone number" />
        </Form.Group>
        <Form.Group className="mb-2" controlId="Email">
          <Form.Label>Email address</Form.Label>
          <Form.Control name="Email" type="email" placeholder="Enter email" />
        </Form.Group>
        <Form.Group className="mb-2" controlId="Username">
          <Form.Label>Username</Form.Label>
          <Form.Control name="Username" type="text" placeholder="Username" />
        </Form.Group>
        <Form.Group className="mb-2" controlId="Password">
          <Form.Label>Password</Form.Label>
          <Form.Control name="Password" type="password" placeholder="Password" />
        </Form.Group>
        <Button variant="primary" type="submit">Register</Button>
      </Form>
    </div>
  );
}

export default RegisterPage;
