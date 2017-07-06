require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:notes) }
  it { should have_many(:followers).class_name('Following').with_foreign_key('followed_id') }
  it { should have_many(:followings).class_name('Following').with_foreign_key('follower_id') }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:following_users).through(:followings).source(:followed) }


  it { should validate_presence_of(:username) }
  describe 'should validate uniqueness of username' do
    subject { User.new(username: 'dsa') }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  # Methods
  describe '#following?' do
    
  end
end
