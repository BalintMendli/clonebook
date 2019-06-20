class PostsController < ApplicationController
  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post saved!'
    elsif
      flash[:danger] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    @posts = current_user.friends_and_own_posts
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:alert] = 'Post deleted!'
    else
      flash[:danger] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
