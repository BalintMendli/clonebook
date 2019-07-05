require 'rails_helper'

feature 'Friend request', type: :feature do
  before :each do
    @user = create(:user)
    @sender = create(:user)
    @friend_request = create(:friend_request, sender: @sender, receiver: @user)
    sign_in @user
  end

  scenario 'has notification in the navbar' do
    visit root_path
    expect(page).to have_content 'Friend Requests(1)'
  end

  scenario 'accepts friend request' do
    visit friend_requests_path
    expect(page).to have_content @sender.name
    click_link 'Confirm'
    expect(page).to have_content 'Friends(1)'
    expect(page).to have_content 'Friend Requests(0)'
    expect(@user.friends_with?(@sender)).to be true
  end

  scenario 'rejects friend request' do
    visit friend_requests_path
    expect(page).to have_content @sender.name
    click_link 'Delete Request'
    expect(page).to have_content 'Friend Requests(0)'
    expect(page).to have_content 'Friends(0)'
    expect(@user.friends_with?(@sender)).to be false
  end
end