import customtkinter
from models import room_type
from views.components import Table
from views.components.Button import *
from views.components.Form import *

class RoomTypePage(customtkinter.CTkFrame):
  def add_room_type(self):
    values = []
    fields = ['TenLoaiPhong', 'DienTich', 'SoKhach', 'MoTa']
    for field in fields:
      values.append(self.input[field].get())
    
    print(values)
    room_type.add_room_type(self.parent.connection, values)

  def show_create_from(self):
    self.create_form = customtkinter.CTkFrame(self)
    self.create_form.grid_columnconfigure(0, weight=1)
    self.create_form.grid_columnconfigure(1, weight=3)

    fields = ['TenLoaiPhong', 'DienTich', 'SoKhach', 'MoTa']
    self.input = {}

    for index, field in enumerate(fields):
      label = customtkinter.CTkLabel(self.create_form, text=field + ': ', width=15)
      label.grid(row=index, column=0, padx=10, pady=5, sticky='W')
      self.input[field] = customtkinter.CTkEntry(self.create_form, width=300, corner_radius=0)
      self.input[field].grid(row=index, column=1, padx=10, pady=5, sticky='W')
    
    save_btn = Button(self.create_form, fg_color='#007dbf', text='Save', command=self.add_room_type)
    save_btn.grid(row=len(fields), column=1, sticky='E', padx=10, pady=5)

    hasattr(self, 'table') and self.table.grid_forget()
    hasattr(self, 'create_form') and self.create_form.grid_forget()

    self.create_form.grid(row=1, column=1)

  def show_room_type_table(self):
    fields = ['TenLoaiPhong', 'DienTich', 'SoKhach', 'MoTa']
    keyword = self.keyword_input.get()
    data = room_type.get_all_room_types(self.parent.connection, fields, keyword)

    hasattr(self, 'table') and self.table.grid_forget()
    hasattr(self, 'create_form') and self.create_form.grid_forget()

    self.table = Table.Table(self, fields=fields, data=data)
    self.table.grid(row=1, column=1, columnspan=10, pady=10)
  
  def handle_return(self, event):
    self.show_room_type_table()
  
  def __init__(self, parent, *args, **kwags):
    super().__init__(parent, *args, **kwags)
    self.parent = parent

    # Layouts   
    self.grid_columnconfigure(0, minsize=200, weight=0)
    self.grid_columnconfigure(1, weight=3)

    # Sidebar

    # - Add button
    add_btn = Button(
      self,
      fg_color='#17a2b8',
      text='Add room type',
      height=30,
      command=self.show_create_from
    )
    add_btn.grid(row=0, column=0, padx=20, pady=20, sticky='N')

    # - Get all button
    get_all_btn = Button(
      self, fg_color='#28a745',
      text='Get all room types',
      height=30,
      command=self.show_room_type_table
    )
    get_all_btn.grid(row=1, column=0, padx=20, pady=20, sticky='N')

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
      command=self.show_room_type_table
    )
    self.search_btn.grid(row=0, column=1, padx=5, pady=5)

    self.keyword_input.bind('<Return>', self.handle_return)


    self.search_section.grid(row=0, column=1)
