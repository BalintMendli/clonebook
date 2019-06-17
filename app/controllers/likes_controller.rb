class LikesController < ApplicationController
  def new
  end

  def create
    Post.find_by(id: params[:id]).likes.create(user_id: current_user.id)
    redirect_back(fallback_location: profile_path)
  end

  def destroy
    like = Like.find_by(id: params[:id])
    like.destroy
    redirect_back(fallback_location: profile_path)
  end
end
