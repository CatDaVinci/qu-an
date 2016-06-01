require_relative '../acceptance_helper'

feature 'Edit qestion', %q{
  In order to edit question
  As an author of question
  I want edit my question
} do

  given(:me)   { create(:user) }
  given(:user) { create(:user) }
  given!(:my_question) { create(:question, user: me) }

  context 'Author edit own question' do

    before { sign_in(me) }

    scenario 'with valid data', js: true do
      visit questions_path
      click_on 'Edit'
      fill_in 'Title', with: 'New title'
      fill_in 'Body',  with: 'New body'
      click_on 'Submit'
      expect(page).to have_content 'New title'
      expect(page).to have_content 'New body'
      expect(page).to have_content 'Question was succesfully update!'
      expect(current_path).to eq questions_path
    end

    scenario 'with invalid data', js: true do
      visit questions_path
      click_on 'Edit'
      fill_in 'Title', with: ''
      fill_in 'Body',  with: ''
      click_on 'Submit'
      expect(page).to have_content 'You fill invalid data!'
    end
  end

  scenario 'Authentication user can`t edit foreign question' do
    sign_in(user)

    visit questions_path
    expect(page).to_not have_link 'Edit'
  end

  scenario 'User can`t edit foreign question' do
    visit questions_path
    expect(page).to_not have_link 'Edit'
  end

end
