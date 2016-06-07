class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable

  validates :body, :question, :user, presence: true
  validates :body, length: { in: 1..10000 }

  accepts_nested_attributes_for :attachments

  def make_best!
    ActiveRecord::Base.transaction do
      question.answers.where(best: true).each { |a| a.update!(best: false) }
      update_attribute(:best, true)
    end
  end
end
