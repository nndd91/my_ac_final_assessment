class FollowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :otherusers]
  def index
    @users = current_user.following_users
  end

  def otherusers
    @users = current_user.not_following
  end

  def create
    current_user.follow(@user)
    StatusUpdateMailer.follow_update_email(@user, current_user, "followed").deliver_now
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.followings.find_by(followed_id: @user).destroy
    StatusUpdateMailer.follow_update_email(@user, current_user, "unfollowed").deliver_now
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
