class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends

  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
        flash[:notice] = "添加成功"
        redirect_to users_path
    else
      flash[:alert] = "添加失败"
      redirect_to users_path
    end

  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy
    flash[:notice] = "删除成功"
    redirect_to root_url
  end
end
