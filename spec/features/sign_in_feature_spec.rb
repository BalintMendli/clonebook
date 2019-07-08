require 'rails_helper'

feature 'Sign in', type: :feature do
  before :each do
    @user = create(:user, email: 'test@test.com', password: 'password')
  end

  scenario 'signs in with correct data' do
    visit new_user_session_path
    within('#signin_new_user') do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'does not sign in with incorrect password' do
    visit new_user_session_path
    within('#signin_new_user') do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'wrong password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'does not sign in with incorrect email' do
    visit new_user_session_path
    within('#signin_new_user') do
      fill_in 'Email', with: 'wrong@email.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end