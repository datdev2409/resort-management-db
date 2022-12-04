import customtkinter
from views.components.Table import *
from views.components.Button import *
from models.procedure import *

class StatsPage(customtkinter.CTkFrame):
  def __init__(self, parent, *args, **kwagrs):
    super().__init__(parent, *args, **kwagrs)
    self.parent = parent

    cn_label = customtkinter.CTkLabel(self, text='MaChiNhanh' + ': ', width=15)
    cn_label.grid(row=0, column=0, padx=10, pady=5, sticky='W')
    self.cn_input = customtkinter.CTkEntry(self, width=300, corner_radius=0)
    self.cn_input.grid(row=0, column=1, padx=10, pady=5, sticky='W')

    year_label = customtkinter.CTkLabel(self, text='Year' + ': ', width=15)
    year_label.grid(row=1, column=0, padx=10, pady=5, sticky='W')
    self.year_input = customtkinter.CTkEntry(self, width=300, corner_radius=0)
    self.year_input.grid(row=1, column=1, padx=10, pady=5, sticky='W')

    btn = Button(self, text='Get result', fg_color='#007dbf', command=self.show_stats)
    btn.grid(row=2, column=0)
  
  def show_stats(self):
    fields = ['Month', 'Luot Khach']
    data = get_statistic(self.parent.connection, self.cn_input.get(), self.year_input.get())
    self.table = Table(self, fields=fields, data=data)


    hasattr(self, 'table') and self.table.grid_forget()
    self.table.grid(row=3, column=1)
