import customtkinter
from views.components.FormRow import *

class Form(customtkinter.CTkFrame):
  def __init__(self, parent, *args, fields=[], **kwags):
    super().__init__(parent, *args, **kwags)

    for index, field in enumerate(fields):
      row = FormRow(self, field=field)
      row.pack(fill=customtkinter.Y)
