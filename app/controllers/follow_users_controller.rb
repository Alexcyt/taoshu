class FollowUsersController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:follow_user][:followed_id])
    current_user.follow_person!(@user)
    respond_to do |format|
      format.html { @user }
      format.js
    end
  end

  def destroy
    @user = FollowUser.find(params[:id]).followed
    current_user.unfollow_person!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
