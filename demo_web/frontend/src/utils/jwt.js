function storeToken(jwt) {
  localStorage.setItem('token', jwt)
}

function getToken() {
  return localStorage.getItem('token')
}

export {storeToken, getToken}
