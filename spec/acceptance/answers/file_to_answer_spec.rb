require_relative '../acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, user: user, question: question, attachments: create_list(:attachment, 2)) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add files when asks question', js: true do
    fill_in 'Body', with: 'My answer'
    click_on 'Add file'
    within '#files' do
      file_inputs = all("input[type='file']")
      if file_inputs.count == 2
        file_inputs[0].set "#{Rails.root}/spec/spec_helper.rb"
        file_inputs[1].set "#{Rails.root}/spec/rails_helper.rb"
      end
    end
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end
  end

  context 'Author' do
    scenario 'can delete file' do
      within "#answer_#{answer.id}" do
        all('.remove-answer-file').first.click
      end
      expect(page).to have_content("Success destroyed")
      within "#answer_#{answer.id}" do
        expect(page).to have_css('.remove-answer-file', count: 1)
      end
    end
  end
end
