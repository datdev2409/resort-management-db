import customtkinter
from views.components import Square as sq

class Row(customtkinter.CTkFrame):
  def __init__(self, *args, data=(), header=False, **kwagrs):
    super().__init__(*args, **kwagrs)
    self.data = data

    for i in range(len(data)):
      square = sq.Square(self, text=data[i], header=header)
      square.grid(row=0, column=i, sticky='W')
      square.bind('<Button-1>', self.handle_click)
  
  def handle_click(self, event):
    print(event)
    
  
    
