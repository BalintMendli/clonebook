class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = current_user.comments.build(comments_params)
    if @comment.save
      flash[:success] = 'Comment saved!'
    else
      p @comment.errors.full_messages
      flash[:danger] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:success] = 'Comment deleted!'
    else
      flash[:danger] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  private

    def comments_params
      params.require(:comment).permit(:content, :post_id)
    end
end
