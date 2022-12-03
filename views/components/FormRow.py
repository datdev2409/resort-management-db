import customtkinter

class FormRow(customtkinter.CTkFrame):
  def __init__(self, parent, *args, field='', **kwags):
    super().__init__(parent, *args, **kwags)

    self.field = field
    label = customtkinter.CTkLabel(self, text=field, width=30)
    # label.grid(row=1, column=0, padx=5, pady=5, sticky=customtkinter.W)
    label.pack(side=customtkinter.LEFT)
    self.input = customtkinter.CTkEntry(self, width=300, corner_radius=0)
    self.input.pack(side=customtkinter.RIGHT)
    # self.input.grid(row=1, column=1, padx=5, pady=5)

  def get_value(self):
    return (self.field, self.input.get())
