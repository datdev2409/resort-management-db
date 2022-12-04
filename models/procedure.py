def get_statistic(connector, branchID, year):
  cursor = connector.cursor()
  args = [branchID, year]
  cursor.callproc('ThongKeLuotKhach', args)

  result = []

  for stat in cursor.stored_results():
    stats = stat.fetchall()

  for i in range(1, 13):
    result.append((i, 0))
  
  for (month, data) in stats:
    index = month - 1
    x = list(result[index])
    x[1] = data
    result[index] = tuple(x)
    # result[index][1] = data
  
  return result

