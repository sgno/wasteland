class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to current_user
    else
      flash[:notice] = "Post failed! Please add some text."
      redirect_to current_user
    end
  end

  private

    def post_params
      params.require(:post).permit(:content, :picture)
    end
end
