class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Created comment"
      redirect_to current_user
    else
      flash[:notice] = "Failed to create comment"
      redirect_to current_user
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end

end
