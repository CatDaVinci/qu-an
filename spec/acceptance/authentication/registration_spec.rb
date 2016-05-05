require 'rails_helper'

feature 'User register', %q{
  In Order to answer on questions
  AS a known user
  I want register on this website
} do

  scenario 'register with valid date' do
    visit root_path
    click_on 'Sign up'

    fill_in 'Email', with: 'test@mail.ru'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_button 'Sign up'

    expect(page).to have_content('Hello, test@mail.ru')
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(current_path).to eq root_path
  end

  scenario 'register with invalid date' do
    visit root_path
    click_on 'Sign up'

    fill_in 'Email', with: 'test@mail.ru'
    fill_in 'Password', with: '1234'
    fill_in 'Password confirmation', with: '123456'

    click_button 'Sign up'

    expect(page).to have_content('2 errors prohibited this user from being saved:')
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(current_path).to eq '/users'
  end
end
