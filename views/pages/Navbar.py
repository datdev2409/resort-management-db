import customtkinter
from views.components.Button import *

class Navbar(customtkinter.CTkFrame):
  def __init__(self, parent, *args, **kwags):
    super().__init__(parent, *args, **kwags)
    self.parent = parent

    home_btn = Button(self, text='Home', command=self.parent.to_home_page)
    customer_btn = Button(self, text='Customer Management', command=self.parent.to_customer_page)
    room_btn = Button(self, text='Room Management')
    logout_btn = Button(self, text='Logout', command=self.parent.logout)

    home_btn.grid(row=0, column=0, ipadx=10)
    customer_btn.grid(row=0, column=1, ipadx=10)
    room_btn.grid(row=0, column=2, ipadx=10)
    logout_btn.grid(row=0, column=3, ipadx=10)


