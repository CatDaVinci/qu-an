require 'rails_helper'

feature 'Look through question', %q{
  In order to find answer for some question
  As an user
  I want to be able to see question and answers for it
} do

  given(:user)      { create(:user) }
  given(:question)  { create(:question, user: user) }
  given!(:answer)   { create_list(:answer, 2, question: question, user: user) }

  scenario 'User see question and answers for it' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers = all('.answer-body')
    expect(answers.count).to eq 2
    answers.each { |a| expect(a.text).to eq 'MyText' }
  end
end
