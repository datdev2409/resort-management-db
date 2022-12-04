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
        fg_color='#f4f4f4',
        border_width=0,
        placeholder_text_color='#000',
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
        fg_color='#f4f4f4',
        placeholder_text=text,
        placeholder_text_color='#333',
        **kwagrs
      )
    
    self.configure(state='disabled')
      
