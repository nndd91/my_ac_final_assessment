class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :notes, dependent: :destroy
  has_many :followers, class_name: "Following", foreign_key: "followed_id"
  has_many :followings, class_name: "Following", foreign_key: "follower_id"
  has_many :likes, dependent: :destroy

  def following?(user)
    followings.exists?(followed_id: user)
  end

  def follow(user)
    @following = followings.build(followed: user)
    @following.save
  end

  def liked?(note)
    likes.exists?(note_id: note)
  end

  def like(note)
    @like = likes.build(note: note)
    @like.save
  end

  def unlike(note)
    @like = likes.find_by(note: note)
    @like.destroy
  end
end
