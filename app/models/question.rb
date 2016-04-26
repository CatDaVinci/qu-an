class Question < ActiveRecord::Base
  has_many :answers

  validates :title, :body, presence: true
  validates :body, length: { in: 1..10000 }
  validates :title, length: { in: 1..100 }
end
