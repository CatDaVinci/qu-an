require 'rails_helper'

feature 'Create answer', %q{
  In order to give answer on question
  As an authenticated user
  I want to be able to answer on question
} do

  given(:user)      { create(:user) }
  given!(:question)  { create(:question, user: user) }

  scenario 'Authenticated user create answer with valid data' do
    sign_in user
    visit questions_path
    first('.create-answer').click
    fill_in 'Body', with: 'My answer'
    click_on "Create"

    expect(page).to have_content 'My answer'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user create answer with invalid data' do
    sign_in user
    visit questions_path
    first('.create-answer').click
    fill_in 'Body', with: ''
    click_on "Create"

    expect(page).to_not have_content 'My answer'
  end

  scenario 'Not Authenticated user create answer' do
    visit visit questions_path
    first('.create-answer').click

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end

end
