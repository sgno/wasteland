class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @users = User.all
    @user = User.find(params[:id])

    @posts = @user.posts
    @post = @user.posts.build

    @likes = @user.likes
    @like = @user.likes.build

    @comments = @user.comments
    @comment = @user.comments.build

    @feed_items = @user.feed

  end

  def index
    @users = User.all
    @friend_request = current_user.friend?
    @user = current_user
  end

  def new
  end

  def create
    @user = User.create(user_params)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :location, :occupation, :avatar)
    end

end
