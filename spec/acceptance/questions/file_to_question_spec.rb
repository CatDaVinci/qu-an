require_relative '../acceptance_helper'

feature 'Add files to question' , %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given!(:question_for_edit) {create(:question, user: user, attachments: create_list(:attachment, 2))}

  background do
    sign_in(user)
    visit new_question_path
  end

  context '#create' do
    scenario 'User add files when asks question', js: true do
      fill_in 'Title', with: 'First Question'
      fill_in 'Body', with: 'Where my sandwich?'
      click_link "Add file"
      within '#files' do
        file_inputs = all("input[type='file']")
        if file_inputs.count == 2
          file_inputs[0].set "#{Rails.root}/spec/spec_helper.rb"
          file_inputs[1].set "#{Rails.root}/spec/rails_helper.rb"
        end
      end
      click_on 'Create'
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end
  end

  context 'Author' do
    let(:question) {create(:question, user: user, attachments: create_list(:attachment, 2))}

    scenario 'can delete file' do
      visit question_path(question)
      all('.remove-file').first.click
      expect(page).to have_css('.remove-file', count: 1)
    end
  end

  context 'User can not' do
    let!(:foreign_question) {create(:question, attachments: create_list(:attachment, 2)) }
    before { visit question_path(foreign_question) }

    it 'destroy foreign question s file' do
      within ".question-attachments" do
        expect(page).to_not have_content('remove file')
      end
    end
  end

  context '#edit question' do
    background { visit questions_path }

    scenario 'User add files', js: true do
      within "#question_#{question_for_edit.id}" do
        click_on 'Edit'
      end
      click_link "Add file"
      within '#files' do
        file_inputs = all("input[type='file']")
        file_inputs[-1].set "#{Rails.root}/spec/spec_helper.rb"
      end
      click_on 'Submit'
      within "#question_#{question_for_edit.id}" do
        expect(page).to have_content 'Attachments count: 3'
      end
    end

    scenario 'User remove file', js: true do
      within "#question_#{question_for_edit.id}" do
        click_on 'Edit'
      end
      first('.remove_fields').click
      click_on 'Submit'
      expect(page).to have_content 'Attachments count: 1'
    end
  end
end
