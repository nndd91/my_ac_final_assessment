class FollowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index]
  def index
    @users = User.all
  end

  def create
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.followings.find_by(followed_id: @user).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
