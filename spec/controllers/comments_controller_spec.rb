require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do 
    @user = create(:user)
    @post = create(:post)
    @comment = create(:comment, user: @user, post: @post)
    sign_in @user
  end

  describe '#create' do
    it "creates a comment" do
    expect{ post :create, params: { comment: attributes_for(:comment, post_id: @post) } }.to change{ Comment.count }.by(1)
    expect(response.successful?)
    end
  end

  describe '#destroy' do
    it 'deletes the comment' do
      expect{ delete :destroy, params: { id: @comment } }.to change{ Comment.count }.by(-1)
    expect(response.successful?)
    end
  end
end