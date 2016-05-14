module AcceptenceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  #TODO Переделать тесты используя этот метод
  def user_sees_notice(text)
    expect(page).to have_css '.notice', text: text
  end
end
