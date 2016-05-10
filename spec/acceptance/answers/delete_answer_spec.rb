require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer on question
  As an author
  I want to be able to delete answer
} do

  given(:me)        { create(:user) }
  given(:user)      { create(:user) }
  given(:question)  { create(:question, user: me) }
  given!(:answer)   { create(:answer, question: question, user: me) }

  scenario 'Author can delete own answer' do
    sign_in me
    visit question_path(question)

    first('.destroy-answer').click

    expect(current_path).to eq question_path(question)
    expect(all('.answer').count).to eq 0
  end

  scenario 'Authorized user can delete foreign answer' do
    sign_in user
    visit question_path(question)

    expect(all('.destroy-answer').count).to eq 0
  end

  scenario 'Unauthorized user can delete foreign answer' do
    visit question_path(question)

    expect(all('.destroy-answer').count).to eq 0
  end

end
