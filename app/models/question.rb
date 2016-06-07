class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  belongs_to :user

  validates :title, :body, :user, presence: true
  validates :body, length: { in: 1..10000 }
  validates :title, length: { in: 1..100 }

  accepts_nested_attributes_for :attachments

  def order_answers_by_best
    answers.order("best desc")
  end
end
