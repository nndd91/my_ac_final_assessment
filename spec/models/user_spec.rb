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
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let!(:following) { create(:following, follower: user, followed: user2)}
    it { expect(user.following?(user2)).to eq(true) }
  end

  describe '#follow' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    it 'should follow user2' do
      user.follow(user2)
      expect(user.following?(user2)).to eq(true)
    end
  end

  describe '#liked?' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:note) { create(:note, user: user2) }
    let!(:like) { create(:like, note: note, user: user) }
    it { expect(user.liked?(note)).to eq(true) }
  end

  describe '#like' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:note) { create(:note, user: user2) }
    it 'should like the note' do
      user.like(note)
      expect(user.liked?(note)).to eq(true)
    end
  end

  describe '#unlike' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:note) { create(:note, user: user2) }
    let!(:like) { create(:like, note: note, user: user) }
    it 'should unlike the note' do
      user.unlike(note)
      expect(user.liked?(note)).to eq(false)
    end
  end

  describe '#feed' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let!(:note1) { create(:note, user: user) }
    let!(:note2) { create(:note, user: user2) }
    let!(:note3) { create(:note, user: user3) }

    it 'should show only user and user2 posts' do
      user.follow(user2)
      expect(user.feed).to match_array([note1, note2])
    end
  end
end
