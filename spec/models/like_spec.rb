require 'rails_helper'

RSpec.describe Like, type: :model do
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
      like = build(:like, user: user, post: post)
      expect(like).to be_valid
    end

    it 'should be saved if valid' do
      expect{ create(:like) }.to change{ Like.count }.by(1)
    end

    it 'should be invalid without user' do
      post = create(:post)
      like = build(:like, user: nil, post: post)
      expect(like).not_to be_valid
    end

    it 'should be invalid without post' do
      user = create(:user)
      like = build(:like, user: user, post: nil)
      expect(like).not_to be_valid
    end

    it 'should not allow duplicate like' do
      user = create(:user)
      post = create(:post)
      like = create(:like, user: user, post: post)
      expect(like).to be_valid
      like2 = build(:like, user: user, post: post)
      expect(like2).not_to be_valid
    end
  end
end