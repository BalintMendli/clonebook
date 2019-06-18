class FriendRequestsController < ApplicationController
  def new
  end

  def create
    friend_request = FriendRequest.new(sender_id: current_user.id, receiver_id: params[:id])
    if friend_request.save
      flash[:success] = 'Friend request sent!'
    else
      flash[:danger] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
    friend_request = FriendRequest.find_by(sender_id: params[:id], receiver_id: current_user.id)
    if friend_request.update_attributes(accepted: true)
      flash[:success] = 'Friend request accepted!'
    else
      flash[:danger] = 'Something went wrong...'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    friend_request = FriendRequest.find_by(sender_id: params[:id], receiver_id: current_user.id) || 
    FriendRequest.find_by(sender_id: current_user.id, receiver_id: params[:id])
    friend_request.destroy
    redirect_back(fallback_location: root_path)
  end

  def index
    @requests = current_user.received_requests_users
  end

  def friends
    @friends = current_user.friends
  end
end
