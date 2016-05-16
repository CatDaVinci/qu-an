require 'rails_helper'

feature 'Create answer', %q{
  In order to give answer on question
  As an authenticated user
  I want to be able to answer on question
} do

  given(:user)       { create(:user) }
  given!(:question)  { create(:question, user: user) }

  scenario 'Authenticated user create answer with valid data', js: true do
    sign_in user
    visit question_path(question)
    fill_in 'Body', with: 'My answer'
    click_on "Create"

    within '.answers' do
      expect(page).to have_content('My answer')
    end

    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user create answer with invalid data', js: true do
    sign_in user
    visit question_path(question)
    fill_in 'Body', with: ''
    click_on "Create"
    expect(page).to have_content 'You fill invalid data for answer!'
  end

  scenario 'Not Authenticated user create answer' do
    visit visit questions_path

    expect(page).to_not have_content 'Yor answer'
  end

end
