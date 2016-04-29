require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new, question_id: question }

    it 'assign new answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'should render new' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'save answer in db' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'should redirect to show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'doesnt save answer in db' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(question.answers, :count)
      end

      it 'should redirect to new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end
end
