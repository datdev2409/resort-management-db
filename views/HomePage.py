import customtkinter
from models import customer
from views.components import Table, Button

class HomePage(customtkinter.CTkFrame):
  def __init__(self, parent, *args, **kwags):
    super().__init__(parent, *args, **kwags)
    self.parent = parent

    customer_page_btn = Button.Button(
      self, text='Customer Management', command=parent.to_customer_page
    )

    room_page_btn = Button.Button(self, text='Room Management')

    customer_page_btn.pack()
    room_page_btn.pack()
