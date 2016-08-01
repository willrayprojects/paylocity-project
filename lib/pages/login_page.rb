class LoginPage < BasePage

  text_field(:username, name: 'form-username')
  text_field(:password, name: 'form-password')
  button(:submit, id: 'btnLogin')

  def login(username, password)
    self.username = username
    self.password = password
    submit
  end
end