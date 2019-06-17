class PostsController < ApplicationController
  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to profile_path
    elsif
      render :new
    end
  end

  def index
    @posts = current_user.friends_posts + current_user.posts
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:alert] = 'Post created'
    redirect_to profile_path
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
