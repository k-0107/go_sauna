class Public::RelationshipsController < ApplicationController

  #権限設定
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page])
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page])
  end
end
