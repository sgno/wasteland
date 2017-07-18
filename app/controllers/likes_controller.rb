class LikesController < ApplicationController
  def create
    @likes = current_user.likes.build(:post_id => params[:post_id])
    if @likes.save
      flash[:notice] = "Liked post"
      redirect_to current_user
    else
      flash[:notice] = "Can't like post.. sorry about that."
      redirect_to current_user
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:user_id])
    @like.destroy if @like != nil
    flash[:notice] = "Unliked post"
    redirect_to current_user
  end
end
