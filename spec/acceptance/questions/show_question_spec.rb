require 'rails_helper'

feature 'Look through question', %q{
  In order to find answer for some question
  As an user
  I want to be able to see question and answers for it
} do

  given(:user)       { create(:user) }
  given(:question)   { create(:question, user: user) }
  given!(:answer1)   { create(:answer, question: question, user: user, body: 'MyText1') }
  given!(:answer2)   { create(:answer, question: question, user: user, body: 'MyText2') }

  scenario 'User see question and answers for it' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    within '.answers' do
      expect(page).to have_content 'MyText1'
      expect(page).to have_content 'MyText2'
    end
  end
end
