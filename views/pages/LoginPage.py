import tkinter as tk
import customtkinter
from tkinter import messagebox as mb
from mysql.connector import connect, Error

class LoginPage(customtkinter.CTkFrame):
  def __init__(self, parent, *args, **kwags):
    super().__init__(parent, *args, **kwags)
    self.parent = parent

    heading = customtkinter.CTkLabel(self, text='Login to Database', font=('Roboto', 30))
    heading.grid(row=0, column=0, columnspan=2, padx=5, pady=10, sticky='W')

    username_label = customtkinter.CTkLabel(self, text='Username: ', width=10)
    username_label.grid(row=1, column=0, padx=5, pady=5, sticky='W')
    self.username_input = customtkinter.CTkEntry(self, width=300, corner_radius=0)
    self.username_input.grid(row=1, column=1, padx=5, pady=5)

    password_label = customtkinter.CTkLabel(self, text='Password: ', width=10)
    password_label.grid(row=2, column=0, padx=5, pady=5, sticky='W')
    self.password_input = customtkinter.CTkEntry(self, width=300, show='*', corner_radius=0)
    self.password_input.grid(row=2, column=1, padx=5, pady=5)

    login_btn = customtkinter.CTkButton(self, text='Login', command=self.login, corner_radius=0)
    login_btn.grid(row=3, column=0, columnspan=2, padx=5, pady=5, sticky='W')
  
  def login(self):
    try: 
      self.parent.connection = connect (
        host = 'localhost',
        user = self.username_input.get(),
        password  = self.password_input.get(),
        database = 'RESORT'
      )
      
      mb.showinfo('Success', 'Database connected')
      self.parent.to_home_page()
    except Error as e:
      self.password_input.delete(0, tk.END)
      mb.showerror('Error', 'Authentication failed')


  