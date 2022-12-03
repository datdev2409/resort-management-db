import customtkinter
from models import customer
from views.components import Table
from views.components.Button import *
from views.components.Form import *

class CustomerPage(customtkinter.CTkFrame):
  def show_customer_table(self):
    fields = ['MaKhachHang', 'HoVaTen', 'Email', 'Diem', 'Loai']
    keyword = self.keyword_input.get()
    data = customer.get_all_customers(self.parent.connection, fields, keyword)

    hasattr(self, 'table') and self.table.pack_forget()
    self.table = Table.Table(self, fields=fields, data=data)
    self.table.pack(padx=10, pady=10, expand=1, anchor=customtkinter.N)
  
  def add_customer(self):
    window = customtkinter.CTkToplevel(self)
    window.geometry('400x200')
    window.title('Add new customer')

    label = customtkinter.CTkLabel(window, text="Add new customer")
    label.pack(side="top", fill="both", expand=True, padx=40, pady=40)

    fields = ['CCCD', 'HoVaTen', 'DienThoai', 'Email', 'Username', 'Password', 'Diem', 'Loai']
    form = Form(window, fields=fields)
    form.pack()
  
  def handle_return(self, event):
    self.show_customer_table()
  
  def __init__(self, parent, *args, **kwags):
    super().__init__(parent, *args, **kwags)
    self.parent = parent

    # Search Section
    self.search_section = customtkinter.CTkFrame(self)
    self.keyword_input = customtkinter.CTkEntry(
      master=self.search_section,
      width=400,
      height=30,
      corner_radius=0
    )
    self.keyword_input.grid(row=0, column=0, padx=5, pady=5)
    self.search_btn = customtkinter.CTkButton(
      master=self.search_section,
      text='Search',
      corner_radius=0,
      height=30,
      command=self.show_customer_table
    )
    self.search_btn.grid(row=0, column=1, padx=5, pady=5)

    self.keyword_input.bind('<Return>', self.handle_return)

    # Add button
    add_customer_btn = Button(self.search_section, fg_color='#17a2b8', text='Add customer', height=30, command=self.add_customer)
    add_customer_btn.grid(row=0, column=2, padx=20, pady=20)

    self.search_section.pack()
