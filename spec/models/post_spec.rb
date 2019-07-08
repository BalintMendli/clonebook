require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Associations" do
    it 'belongs to user' do 
      should belong_to(:user) 
    end 

    it 'has many comments' do 
      should have_many(:comments) 
    end

    it 'has many likes' do 
      should have_many(:likes) 
    end
  end
  
  describe "Validations" do
    it 'should be valid with valid data' do
      post = build(:post)
      expect(post).to be_valid
    end

    it 'should be saved if valid' do
      expect{ create(:post) }.to change{ Post.count }.by(1)
    end

    it 'should not be valid without user' do
      post = build(:post, user: nil)
      expect(post).not_to be_valid
    end

    it 'should not be valid without content' do
      post = build(:post, content: '')
      expect(post).not_to be_valid
    end
  end
end