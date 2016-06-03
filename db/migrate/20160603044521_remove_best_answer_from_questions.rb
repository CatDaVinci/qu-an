class RemoveBestAnswerFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :best_answer_id
  end
end
