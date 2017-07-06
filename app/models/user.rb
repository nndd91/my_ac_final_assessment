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

  # 2 tiered relations
  has_many :following_users, through: :followings, source: :followed

  def following?(user)
    followings.exists?(followed_id: user)
  end

  def not_following
    if following_user_ids.count == 0
      User.where("id NOT IN (:following_ids) AND id != :user_id",
                 following_ids: (0),
                 user_id: id)
    else
      User.where("id NOT IN (:following_ids) AND id != :user_id",
                 following_ids: following_user_ids,
                 user_id: id)
    end
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

  def feed
    Note.where("user_id IN (:following_ids) OR user_id = :user_id",
               following_ids: following_user_ids,
               user_id: id)
  end
end
