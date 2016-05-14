require 'rails_helper'

feature 'Edit qestion', %q{
  In order to edit question
  As an author of question
  I want edit my question
} do

  given(:me)   { create(:user) }
  given(:user) { create(:user) }
  given(:my_question) { create(:question, user: me) }
  given(:question)    { create(:question, user: user) }
  given(:auth_user) { create(:user) }

  context 'Author edit own question' do

    before { sign_in(me) }

    scenario 'with valid data' do
      visit question_path(my_question)
      click_on 'Edit'
      fill_in 'Title', with: 'New title'
      fill_in 'Body',  with: 'New body'
      click_on 'Edit'

      expect(page).to have_content 'New title'
      expect(page).to have_content 'New body'
      expect(page).to have_content 'Question was successfully update!'
      expect(current_path).to eq question_path(my_question)
    end

    scenario 'with invalid data' do
      visit question_path(my_question)
      click_on 'Edit'
      fill_in 'Title', with: ''
      fill_in 'Body',  with: ''
      click_on 'Edit'

      expect(page).to have_content 'You fill invalid data!'
    end
  end

  scenario 'Authentication user can`t edit foreign question' do
    sign_in(auth_user)

    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  scenario 'User can`t edit foreign question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

end
