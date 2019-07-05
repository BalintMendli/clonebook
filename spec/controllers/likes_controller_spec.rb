require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before(:each) do
    @user = create(:user)
    @post = create(:post)
    @like = create(:like, user: @user)
    sign_in @user
  end

  describe '#create' do
    it 'creates a new like' do
      expect{ post :create, params: { id: @post.id } }.to change{ Like.count }.by(1)
      expect(response.successful?)
    end
  end

  describe "#destroy" do
    it 'deletes a like' do
      expect{ delete :destroy, params: { id: @like.id } }.to change{ Like.count }.by(-1)
      expect(response.successful?)
    end
  end
end