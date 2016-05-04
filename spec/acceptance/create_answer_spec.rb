require 'rails_helper'

feature 'Create answer', %q{
  In order to give answer on question
  As an authenticated user
  I want to be able to answer on question
} do

  given(:user)     { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer with valid date' do
    #sign_in user
    visit questions_path(question)
    first('.create-answer').click
    fill_in 'Body', with: 'My answer'
    click_on "Create"

    expect(page).to have_content 'My answer'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user create answer with invalid date' do
    #sign_in user
    visit questions_path(question)
    first('.create-answer').click
    fill_in 'Body', with: ''
    click_on "Create"

    expect(page).to_not have_content 'My answer'
  end

  # scenario 'Not Authenticated user create answer' do
  #   visit new_question_answer_path(question_id: question)
  #
  #   expect(page).to have_content 'For create answer you mast be authenticated user'
  #   expect(current_path).to eq questions_path
  # end

end
