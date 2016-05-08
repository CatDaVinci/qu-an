require 'rails_helper'

feature 'Delete question', %q{
  In order to destroy question
  As an author
  I want destroy only my questions
} do

  given(:me)   { create(:user) }
  given(:user) { create(:user) }
  given(:my_question) { create(:question, user: me) }
  given(:question) { create(:question, user: user, title: 'Delete') }

  before { sign_in(me) }

  scenario 'Author delete own question' do
    visit question_path(my_question)
    click_on 'Delete'

    expect(current_path).to eq questions_path
    expect(all('.question').count).to eq 0
  end

  scenario 'User try delete foreign question' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete'
  end
end
