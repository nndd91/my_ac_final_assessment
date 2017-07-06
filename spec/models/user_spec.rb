require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:notes) }
  it { should validate_presence_of(:username) }
  describe 'should validate uniqueness of username' do
    subject { User.new(username: 'dsa') }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end
end
