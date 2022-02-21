module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user[login]', with: user.username
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
end
