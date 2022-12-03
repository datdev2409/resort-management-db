import React, { useState } from 'react';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';
import axios from 'axios'
import Alert from 'react-bootstrap/Alert';

function LoginPage() {
  const submitURL = 'http://localhost:3000/customer/login'

  const [message, setMessage] = useState('')

  const handleSubmit = async (e) => {
    e.preventDefault()
    const Username = e.target.Username.value
    const Password = e.target.Password.value
    try {
      const res = await axios.post(submitURL, {
        Username, Password 
      })
      // storeToken(res.data.jwt)
      alert("Login successfully")
    }
    catch (error) {
      console.log(error)
      setMessage(error.response.data.message)
    }

  }

  return (
    <div className='d-flex justify-content-center align-items-center'> 
      <Form onSubmit={handleSubmit} className='mt-3 border border-3 p-4 rounded' style={{width: '600px'}}>
        <h3>Login</h3>
        {message && <Alert variant='danger'>{message}</Alert>}
        <Form.Group className="mb-2" controlId="Username">
          <Form.Label>Username</Form.Label>
          <Form.Control name="Username" type="text" placeholder="Username" />
        </Form.Group>
        <Form.Group className="mb-2" controlId="Password">
          <Form.Label>Password</Form.Label>
          <Form.Control name="Password" type="password" placeholder="Password" />
        </Form.Group>
        <Button variant="primary" type="submit">Login</Button>
      </Form>
    </div>
  );
}

export default LoginPage;
