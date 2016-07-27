class AttachmentsController < ApplicationController
  before_action :set_entity

  def destroy
    @attachment = @entity.attachments&.find(params[:id])
    @attachment&.destroy if current_user.id == @entity.user_id
    case @attachment.attachmentable_type
    when 'Question'
      redirect_to question_path(@entity)
    when 'Answer'
      redirect_to answer_path(@entity)
    else
      redirect_to root_path
    end
  end

  private

  def set_entity
    case params[:type]
    when 'question'
      @entity = Question.find(params[:entity_id])
    when 'answer'
      @entity = Answer.find(params[:entity_id])
    end
  end
end
