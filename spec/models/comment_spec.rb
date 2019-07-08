require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Associations" do
    it 'belongs to user' do 
      should belong_to :user 
    end

    it 'belongs to post' do 
      should belong_to :post 
    end
  end
  
  describe "Validations" do
    it 'should be valid with valid data' do
      user = create(:user)
      post = create(:post)
      comment = build(:comment, user: user, post: post)
      expect(comment).to be_valid
    end

    it 'should be saved if valid' do
      user = create(:user)
      post = create(:post)
      expect{ create(:comment, user: user, post: post) }.to change{ Comment.count }.by(1)
    end

    it 'should be invalid without user' do
      post = create(:post)
      comment = build(:comment, user: nil, post: post)
      expect(comment).not_to be_valid
    end

    it 'should be invalid without post' do
      user = create(:user)
      comment = build(:comment, user: user, post: nil)
      expect(comment).not_to be_valid
    end

    it 'should be invalid without content' do
      user = create(:user)
      post = create(:post)
      comment = build(:comment, user: user, post: post, content: '')
      expect(comment).not_to be_valid
    end
  end
end