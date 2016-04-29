require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an user
  I whant to be able to sign in
} do

  given(:user) { create(:user) }

  scenario 'Registered user try sing in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-Registered user try sing in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong_test@mail.ru'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

end
