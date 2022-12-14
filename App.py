import customtkinter
from views.pages.HomePage import *
from views.pages.LoginPage import *
from views.pages.CustomerPage import *
from views.pages.Navbar import *
from views.pages.RoomTypePage import *
from views.pages.StatsPage import *

customtkinter.set_appearance_mode('light')
customtkinter.set_widget_scaling(1.3)

class App(customtkinter.CTk):
  def __init__(self):
    super().__init__()
    self.geometry('1200x900')
    self.title('Resort Management')
    self.corner_raidus = 0

    self.screens = {
      'navbar': Navbar(self),
      'login': LoginPage(self),
      'home': HomePage(self),
      'customer': CustomerPage(self),
      'room_type': RoomTypePage(self),
      'stats': StatsPage(self)
    }

    self.clear_screen()
    self.display_page('login')

    self.connection = None

  def clear_screen(self):
    for screen in self.screens.values():
      screen.pack_forget()

  def display_navbar(self):
    self.screens['navbar'].pack()

  def display_page(self, page_name):
    self.screens[page_name].pack(expand=1, fill=customtkinter.BOTH, pady=20)

  def to_home_page(self):
    self.clear_screen()
    self.display_navbar()
    self.display_page('home')
  
  def to_customer_page(self):
    self.clear_screen()
    self.display_navbar()
    self.display_page('customer')

  def to_room_type_page(self):
    self.clear_screen()
    self.display_navbar()
    self.display_page('room_type')
  
  def to_stats_page(self):
    self.clear_screen()
    self.display_navbar()
    self.display_page('stats')

  def logout(self):
    self.connection = None
    self.clear_screen()
    self.display_page('login')
  

  



