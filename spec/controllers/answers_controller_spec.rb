require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user

  let(:question) { create(:question, user: @user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      let (:create_request) { post :create, question_id: question, answer: attributes_for(:answer), format: :js }
      it 'save answer in db' do
        expect { create_request }.to change(question.answers, :count).by(1)
      end

      it 'should render to create template' do
        create_request
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      let (:create_invalid_request) { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }
      it 'doesnt save answer in db' do
        expect { :create_invalid_request }.to_not change(Answer, :count)
      end

      it 'should render to create template' do
        create_invalid_request
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:my_answer)  { create(:answer, question: question, user: @user) }
    let(:user)        { create(:user) }
    let!(:answer)     { create(:answer, question: question, user: user) }

    it 'delete my question' do
      expect { delete :destroy, id: my_answer, question_id: question }.to change(question.answers, :count).by(-1)
    end

    it 'redirect to index view after delete my question' do
      delete :destroy, id: my_answer, question_id: question
      expect(response).to redirect_to question_path(question)
    end

    it 'delete foreign question' do
      expect { delete :destroy, id: answer, question_id: question }.to change(question.answers, :count).by(0)
    end
  end
end
