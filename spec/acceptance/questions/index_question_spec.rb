require 'rails_helper'

feature 'Look through questions', %q{
  In order to find some question in list
  As an user
  I want to be able to see list of questions
} do

  given!(:questions) { create_list(:question, 5) }

  scenario 'User look through questions' do
    visit questions_path

    expect(all('.question').count).to eq 5
  end

end
