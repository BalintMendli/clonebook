class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comments_params)
    if @comment.save
      flash[:success] = 'Comment saved!'
      redirect_back(fallback_location: profile_path)
    else
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:success] = 'Comment deleted!'
    end
    redirect_back(fallback_location: profile_path)
  end

  private

    def comments_params
      params.require(:comment).permit(:content, :post_id)
    end
end
