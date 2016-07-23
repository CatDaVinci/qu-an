require_relative '../acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add files when asks question', js: true do
    visit question_path(question)
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
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    end
  end
end
