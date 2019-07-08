require 'rails_helper'

feature "Post", type: :feature do
  before :each do
    @user = create(:user)
    sign_in @user
    @post = create(:post, user: @user)
  end

  scenario 'creates post with valid content' do
    visit root_path
    expect(page).to have_content 'Create post'
    within('.new-post-box form') do
      fill_in 'post_content', with: 'test post'
    end
    click_button 'Share'
    expect(page).to have_content 'Post saved'
    expect(page).to have_content 'test post'
  end

  scenario 'does not create post with invalid content' do
    visit root_path
    within('.new-post-box form') do
      fill_in 'post_content', with: ''
    end
    click_button 'Share'
    expect(page).to have_content "Something went wrong"
  end

  scenario 'deletes a post' do
    visit root_path
    expect(page).to have_link(href: post_path(@post))
    click_link(href: post_path(@post))
    expect(page).to have_content 'Post deleted'
    expect(page).not_to have_content 'Lorem'
  end

end