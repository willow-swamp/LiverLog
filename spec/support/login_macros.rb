module LoginMacros
  def login_line(user)
    login_user(user, profile_path)
    visit profile_path
  end
end
