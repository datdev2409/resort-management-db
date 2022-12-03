import customtkinter

class Button(customtkinter.CTkButton):
  def __init__(self, *args, height=30, fg_color='#333', **kwags):
    super().__init__(*args, corner_radius=0, fg_color=fg_color, **kwags)
    self.height = height
