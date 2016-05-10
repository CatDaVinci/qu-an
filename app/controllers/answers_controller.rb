class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question


  def new
    @answer = Answer.new(question: @question, user: current_user)
  end

  def create
    @answer = @question.answers.new(answer_params.merge({ user: current_user }))
    if @answer.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy if current_user.id == @answer.user.id
    redirect_to @question
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
