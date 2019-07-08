require 'rails_helper'

feature 'Like', type: :feature do
  before :each do
    @user = create(:user)
    @post = create(:post, user: @user)
    sign_in @user
  end

  scenario 'likes a post' do
    visit profile_path(@user)
    within '.post-box' do
      click_link 'Like'
    end
    expect(page).to have_link('Unlike')
    expect(page).to have_content 'Post liked'
  end

  scenario 'unlikes a post' do
    create(:like, user: @user, post: @post)
    visit profile_path(@user)
    within '.post-box' do
      click_link 'Unlike'
    end
    expect(page).to have_link('Like')
    expect(page).to have_content 'Post unliked'
  end
end