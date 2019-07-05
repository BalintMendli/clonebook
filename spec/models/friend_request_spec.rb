require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe "Associations" do
    it 'belongs to sender' do 
      should belong_to :sender 
    end 

    it 'belongs to receiver' do 
      should belong_to :receiver
    end
  end
  
  describe "Validations" do
    it 'should be valid with valid data' do
      friend_request = build(:friend_request)
      expect(friend_request).to be_valid
    end

    it 'should be saved if valid' do
      expect{ create(:friend_request) }.to change{ FriendRequest.count }.by(1)
    end

    it 'should not allow duplicate friend requests' do
      user=create(:user)
      user2=create(:user)
      friend_request=create(:friend_request, sender: user, receiver: user2)
      expect(friend_request).to be_valid
      friend_request2=build(:friend_request, sender: user, receiver: user2)
      expect(friend_request2).not_to be_valid
    end

    it 'should not allow duplicate friend requests the other way' do
      user=create(:user)
      user2=create(:user)
      friend_request=create(:friend_request, sender: user, receiver: user2)
      expect(friend_request).to be_valid
      friend_request2=build(:friend_request, sender: user2, receiver: user)
      expect(friend_request2).not_to be_valid
    end

    it 'should make friends if friend request is accepted' do
      user=create(:user)
      user2=create(:user)
      friend_request=create(:friend_request, sender: user, receiver: user2, accepted: true)
      expect(user.friends_with?(user2)).to be true
    end
  end
end