class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :load_question, only: [:show, :update, :destroy]
  before_action :redirect_if_not_own_question, only: [:update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    @change_best = true if question_params[:best_answer_id]
    @question.update(question_params)
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :best_answer_id)
  end

  def redirect_if_not_own_question
    if current_user.id != @question.user_id
      redirect_to root_path
    end
  end
end
