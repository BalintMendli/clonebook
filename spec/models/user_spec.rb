require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    let(:user) { build(:user) }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without a first_name" do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it "is not valid without a last_name" do
      user.last_name = nil
      expect(user).not_to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "is not valid without password" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "is not valid when younger than 13" do
      user.birthday = 10.year.ago
      expect(user).not_to be_valid
    end
  end

  describe "Associations" do
    it 'has many posts' do 
      should have_many(:posts) 
    end

    it 'has many comments' do 
      should have_many(:comments) 
    end

    it 'has many likes' do 
      should have_many(:likes) 
    end
  end

  describe User, '#name' do
    it 'returns the full name' do
      user = build(:user)
      expect(user.name).to eq 'John Doe'
    end
  end

  describe User, '#friends_with?' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'returns true if friends' do
      friendship = create(:friend_request, sender: @user, receiver: @user2, accepted: true)
      expect(@user.friends_with?(@user2)).to be true
    end

    it 'returns false if not friends' do
      expect(@user.friends_with?(@user2)).to be false
    end
    
    it 'returns false if friend request is not accepted' do
      friendship = create(:friend_request, sender: @user, receiver: @user2, accepted: false)
      expect(@user.friends_with?(@user2)).to be false
    end
  end

  describe User, '#liked' do
    before do
      @user = create(:user)
      @post = create(:post)
    end

    it 'returns like object if post liked by user' do
      like = create(:like, user: @user, post: @post)
      expect(@user.liked(@post)).to eq like
    end

    it 'returns nil if post not liked by user' do
      expect(@user.liked(@post)).to be nil
    end
  end

  describe User, '#friend_request_from?' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'returns true if user has a friend request from the other user' do
      friendship = create(:friend_request, sender: @user2, receiver: @user)
      expect(@user.friend_request_from?(@user2)).to be true
    end

    it 'returns false if user does not have a friend request from the other user' do
      expect(@user.friend_request_from?(@user2)).to be false
    end
  end

  describe User, '#friend_request_to?' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'returns true if user sent a friend request to the other user' do
      friendship = create(:friend_request, sender: @user, receiver: @user2)
      expect(@user.friend_request_to?(@user2)).to be true
    end
    
    it 'returns false if user has not sent a friend request to the other user' do
      expect(@user.friend_request_to?(@user2)).to be false
    end
  end

  describe User, '#friends?' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'includes user if he is a friend' do
      friendship = create(:friend_request, sender: @user, receiver: @user2, accepted: true)
      expect(@user.friends).to include @user2
    end
    
    it 'does not include user if he is not a friend' do
      expect(@user.friends).not_to include @user2
    end
  end

  describe User, '#friends_and_own_posts' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'includes friends post' do
      friendship = create(:friend_request, sender: @user, receiver: @user2, accepted: true)
      post = create(:post, user: @user2)
      expect(@user.friends_and_own_posts).to include post
    end
    
    it 'includes own post' do
      post = create(:post, user: @user)
      expect(@user.friends_and_own_posts).to include post
    end

    it 'does not include post if it is not from a friend' do
      post = create(:post, user: @user2)
      expect(@user.friends_and_own_posts).not_to include post
    end
  end

  describe User, '#sent_requests_users' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'includes user if we sent him a friend request' do
      friendship = create(:friend_request, sender: @user, receiver: @user2)
      expect(@user.sent_requests_users).to include @user2
    end
    
    it 'does not include user if we did not send him a friend request' do
      expect(@user.sent_requests_users).not_to include @user2
    end
  end

  describe User, '#received_requests_users' do
    before do
      @user = create(:user)
      @user2 = create(:user)
    end

    it 'includes user if he sent us a friend request' do
      friendship = create(:friend_request, sender: @user2, receiver: @user)
      expect(@user.received_requests_users).to include @user2
    end
    
    it 'does not include user if he did not send us a friend request' do
      expect(@user.received_requests_users).not_to include @user2
    end
  end
end