def get_all_room_types(connector, attrs, keyword=''):
  attrs = ', '.join(attrs) 
  query_room_types = f'SELECT {attrs} FROM LoaiPhong WHERE TenLoaiPhong LIKE \'%{keyword}%\''
  cursor = connector.cursor()
  cursor.execute(query_room_types)

  room_types = cursor.fetchall()
  return room_types

def add_room_type(connector, values):
  values = map(lambda value : '\'' + value + '\'', values)
  values = ', '.join(values)
  print(values)
  create_query = f'INSERT INTO LoaiPhong (TenLoaiPhong, DienTich, SoKhach, MoTa ) VALUES ({values})'  
  print(create_query)

  cursor = connector.cursor()
  cursor.execute(create_query)

  connector.commit()
  print('Created new room type')
