import customtkinter

class Square(customtkinter.CTkEntry):
  def __init__(self, *args, header=False, text, **kwagrs):
    if (header):
      super().__init__(
        *args,
        height=50,
        width=200,
        corner_radius=0,
        bg_color='#333',
        fg_color='#333',
        border_width=0,
        placeholder_text_color='#fff',
        placeholder_text=text,
        **kwagrs
      )
    
    else:
      super().__init__(
        *args,
        height=50,
        width=200,
        corner_radius=0,
        border_width=0,
        bg_color='#333',
        fg_color='#333',
        placeholder_text=text,
        **kwagrs
      )
    
    self.configure(state='disabled')
      
