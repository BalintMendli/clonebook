require 'rails_helper'

feature 'Comment', type: :feature do
  before :each do
    @user = create(:user)
    sign_in @user
    @post = create(:post, user: @user)
  end

  scenario 'creates a comment' do
    visit profile_path(@user)
    within('.comment-box') do
      fill_in 'comment_content', with: 'test comment'
    end
    click_button 'Submit'
    expect(page).to have_content 'Comment saved'
    expect(page).to have_content 'test comment'
  end

  scenario 'deletes a comment' do
    comment = create(:comment, user: @user, post: @post, content: 'test comment')
    visit profile_path(@user)
    expect(page).to have_link(href: comment_path(comment))
    click_link href: comment_path(comment)
    expect(page).to have_content 'Comment deleted'
    expect(page).not_to have_content 'test comment'
  end
end