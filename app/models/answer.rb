class Answer < ActiveRecord::Base
  include Attachable

  belongs_to :question
  belongs_to :user

  validates :body, :question, :user, presence: true
  validates :body, length: { in: 1..10000 }

  def make_best!
    ActiveRecord::Base.transaction do
      question.answers.where(best: true).each { |a| a.update!(best: false) }
      update_attribute(:best, true)
    end
  end
end
