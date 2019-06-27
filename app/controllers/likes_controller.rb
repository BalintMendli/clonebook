class LikesController < ApplicationController
  def new
  end

  def create
    if Post.find_by(id: params[:id]).likes.create(user_id: current_user.id)
      flash[:success] = 'Post liked!'
    else
      flash[:success] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.find_by(id: params[:id])
    if like.destroy
      flash[:success] = 'Post unliked!'
    else
      flash[:success] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end
end
