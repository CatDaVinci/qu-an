require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :question }
  it { should validate_presence_of :user }
  it { should validate_length_of(:body).is_at_least(1).is_at_most(10000) }

  it { should belong_to :question }
  it { should belong_to :user     }
end
