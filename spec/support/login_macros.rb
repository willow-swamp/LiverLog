module LoginMacros
  def skip_login_line(user)
    visit root_path
    page.set_rack_session(user_id: user.id)
    visit profile_path
  end

  def skip_login_invitee(invitee)
    page.set_rack_session(user_id: invitee.id)
    visit group_path(invitee.groups.first)
  end
end
