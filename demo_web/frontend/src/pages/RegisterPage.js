import React from 'react';
import Button from 'react-bootstrap/Button';
import Form from 'react-bootstrap/Form';

function RegisterPage() {
  return (
    <div className='d-flex justify-content-center align-items-center'> 
      <Form className='mt-5 border border-3 p-4 rounded' style={{width: '600px'}}>
        <h3>Register</h3>
        <Form.Group className="mb-3" controlId="Email">
          <Form.Label>Email address</Form.Label>
          <Form.Control name="Email" type="email" placeholder="Enter email" />
        </Form.Group>
        <Form.Group className="mb-3" controlId="Password">
          <Form.Label>Password</Form.Label>
          <Form.Control name="Password" type="password" placeholder="Password" />
        </Form.Group>
        <Button variant="primary" type="submit">Submit</Button>
      </Form>
    </div>
  );
}

export default RegisterPage;
