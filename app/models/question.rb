class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, :user, presence: true
  validates :body, length: { in: 1..10000 }
  validates :title, length: { in: 1..100 }
end
