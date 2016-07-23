require_relative '../acceptance_helper'

feature 'Add files to question' , %q{
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

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
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
  end
end
