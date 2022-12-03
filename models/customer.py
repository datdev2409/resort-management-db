def get_all_customers(connector, attrs, keyword=''):
  attrs = ', '.join(attrs) 
  query_customer = f'SELECT {attrs} FROM KhachHang WHERE HoVaTen LIKE \'%{keyword}%\''
  cursor = connector.cursor()
  cursor.execute(query_customer)

  customers = cursor.fetchall()
  return customers

def add_customer(connector, values):
  values = ', '.join(values)
  print(values)
  create_query = f'INSERT INTO KhachHang (CCCD, HoVaTen, DienThoai, Email, Username, Password, Diem ) VALUES ({values})'  

  cursor = connector.cursor()
  cursor.execute(create_query)

  connector.commit()
  print('Created new customer')
