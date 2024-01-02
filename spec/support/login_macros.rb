module LoginMacros
  def login_as(user)
    login_user(user)
    visit profile_path
  end
end
