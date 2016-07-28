class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question

  def create
    @answer = @question.answers.create(answer_params.merge({ user: current_user }))
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy if current_user.id == @answer.user_id
  end

  def update
    @answer = @question.answers.find(params[:id])
    if params[:answer] && params[:answer][:best]
      @answer.make_best!
    else
      @answer.update(answer_params)
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
