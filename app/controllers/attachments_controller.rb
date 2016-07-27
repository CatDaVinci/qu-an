class AttachmentsController < ApplicationController
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy if current_user.id == @attachment.attachmentable.user_id
    flash[:notice] = "Success destroyed"
    if @attachment.attachmentable_type == "Question"
      redirect_to question_path(@attachment.attachmentable)
    else
      redirect_to question_path(@attachment.attachmentable.question)
    end
  end
end
