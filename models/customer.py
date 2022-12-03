def get_all_customers(connector, attrs, keyword=''):
  attrs = ', '.join(attrs) 
  query_customer = f'SELECT {attrs} FROM KhachHang WHERE HoVaTen LIKE \'%{keyword}%\''
  cursor = connector.cursor()
  cursor.execute(query_customer)

  customers = cursor.fetchall()
  return customers
