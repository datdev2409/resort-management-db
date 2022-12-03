import customtkinter
from views.components import Square, Row

class Table(customtkinter.CTkFrame):
  def __init__(self, *args, fields=[], data=[], **kwags):
    super().__init__(*args, **kwags)

    # Add table header
    header_row = Row.Row(self, data=fields, header=True)
    header_row.pack()

    num_row = len(data)
    for i in range(num_row):
      row = Row.Row(self, data=data[i])
      row.pack()
      row.bind('<Button-1>', lambda event : self.handle_click(event, data[i]))
      
  def handle_click(self, event, data):
    print('event')
    print(data)
