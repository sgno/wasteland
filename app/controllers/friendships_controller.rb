class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Friend requested."
      redirect_to current_user
    else
      flash[:notice] = "Unable to like friend."
      render :action => "new"
    end
  end

  def update
    @friendship = Friendship.find_by("user_id = ? OR friend_id = ?", params[:id], params[:id])
    @friendship.accepted = true
    @friendship.save
    if @friendship.save
      redirect_to current_user
      flash[:notice] = "Friend added."
    else
      redirect_to current_user
      flash[:error] = "Unable to accept friendship"
    end
  end

  def destroy
    @friendship = Friendship.find_by("user_id = ? OR friend_id = ?", params[:id], params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

end
