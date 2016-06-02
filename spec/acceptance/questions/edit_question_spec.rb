require_relative '../acceptance_helper'

feature 'Edit qestion', %q{
  In order to edit question
  As an author of question
  I want edit my question
} do

  given(:me)   { create(:user) }
  given(:user) { create(:user) }
  given!(:my_question) { create(:question, user: me) }
  given!(:answer) { create(:answer, question: my_question) }
  given!(:best_answer) { create(:answer, question: my_question) }

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

    scenario 'choose best answer', js: true do
      visit question_path(my_question)

      within "[data-answer-id='#{best_answer.id}']" do
        click_on "Best"
      end

      expect(page).to have_content 'TOP'
      within '.answers' do
        expect(first('.answer')["data-answer-id"].to_i).to eq best_answer.id
      end
    end
  end

  context 'Authentication user' do
    before { sign_in user }

    scenario 'can`t edit foreign question' do
      visit questions_path
      expect(page).to_not have_link 'Edit'
    end

    scenario 'can`t choose best answer' do
      visit question_path(my_question)

      expect(page).to_not have_content 'Best'
    end
  end

  context 'Not authentication user' do
    scenario 'can`t edit foreign question' do
      visit questions_path
      expect(page).to_not have_link 'Edit'
    end

    scenario 'can`t choose best answer' do
      visit question_path(my_question)

      expect(page).to_not have_content 'Best'
    end
  end
end
