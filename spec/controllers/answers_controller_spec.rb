require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user

  let(:question) { create(:question, user: @user) }

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
      let (:create_request) { post :create, question_id: question, answer: attributes_for(:answer) }
      it 'save answer in db' do
        expect { create_request }.to change(question.answers, :count).by(1)
      end

      it 'should redirect to show view' do
        create_request
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      let (:create_invalid_request) { post :create, question_id: question, answer: attributes_for(:invalid_answer) }
      it 'doesnt save answer in db' do
        expect { :create_invalid_request }.to_not change(Answer, :count)
      end

      it 'should redirect to new view' do
        create_invalid_request
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:my_answer) { create(:answer, question: question, user: @user) }

    it 'delete question' do
      expect { delete :destroy, id: my_answer, question_id: question }.to change(question.answers, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, id: my_answer, question_id: question
      expect(response).to redirect_to question_path(question)
    end
  end
end
