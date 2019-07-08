require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do
  before(:each) do
    @user = create(:user)
    @user2 = create(:user)
    sign_in @user
  end

  describe "#create" do
    it "creates new friend request" do
      expect{ post :create, params: { id: @user2.id } }.to change{ FriendRequest.count }.by(1)
      expect(response.successful?)
      expect{ delete :destroy, params: { id: @user2.id } }.to change{ FriendRequest.count }.by(-1)
      expect(response.successful?)
    end
  end

  describe "#update" do
    it "accepts the friend request" do
      create(:friend_request, sender: @user2, receiver: @user)
      expect{ patch :update, params: { id: @user2.id } }.to change{ @user.friends.count }.by(1)
      expect(response.successful?)
    end
  end

  describe "#destroy" do
    it "deletes the friend request" do
      post :create, params: { id: @user2.id }
      expect{ delete :destroy, params: { id: @user2.id } }.to change{ FriendRequest.count }.by(-1)
      expect(response.successful?)
    end
  end
end