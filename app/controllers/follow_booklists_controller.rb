class FollowBooklistsController < ApplicationController
  before_action :signed_in_user

  def create
    @booklist = Booklist.find(params[:follow_booklist][:booklist_id])
    @button_type = params[:follow_booklist][:btn_type]
    current_user.focus_booklist!(@booklist)
    respond_to do |format|
      format.html { redirect_to @booklist }
      format.js
    end
  end

  def destroy
    @booklist = FollowBooklist.find(params[:id]).booklist
    @button_type = params[:follow_booklist][:btn_type]
    current_user.unfocus_booklist!(@booklist)
    respond_to do |format|
      format.html { redirect_to @booklist }
      format.js
    end
  end
end
