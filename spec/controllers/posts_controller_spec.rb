require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before (:each) do
    @user = create(:user)
    @post = create(:post, user: @user)
    sign_in @user
  end

  describe '#create' do
    it 'creates a new post' do
      expect{ post :create, params: { post: { content: 'test post'} } }.to change{ Post.count }.by(1)
      expect(response.successful?)
    end
  end

  describe '#destroy' do
    it 'deletes the post' do 
      expect{ delete :destroy, params: { id: @post } }.to change{ Post.count }.by(-1)
      expect(response.successful?)
    end
  end
end