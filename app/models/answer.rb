class Answer < ActiveRecord::Base
  belongs_to :question

  validates :body, presence: true
  validates :body, length: { in: 1..10000 }
end
