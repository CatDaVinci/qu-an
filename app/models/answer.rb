class Answer < ActiveRecord::Base
  belongs_to :question

  validates :body, :question, presence: true
  validates :body, length: { in: 1..10000 }
end
