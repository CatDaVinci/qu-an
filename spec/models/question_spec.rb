require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body  }
  it { should validate_presence_of :user  }

  it { should validate_length_of(:title).is_at_least(1).is_at_most(100) }
  it { should validate_length_of(:body).is_at_least(1).is_at_most(10000) }

  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should have_one(:best_answer) }


  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question) }
  let(:best_answer) { create(:answer, question: question) }

  before { question.best_answer_id = best_answer.id }

  it 'order by best answer' do
    expect(question.order_answers_by_best.to_a).to match_array [best_answer, answer]
  end
end
