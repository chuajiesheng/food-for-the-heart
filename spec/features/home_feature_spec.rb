require 'rails_helper'

describe 'home page', :type => :feature do
  it 'show me two links, login and assign meals' do
    visit '/'
    expect(page).to have_content 'Login'
    expect(page).to have_content 'Assign Meals'
  end

  it 'login redirect me to devise login page' do
    visit '/'
    within('.navbar') do
      click_link 'Login'
    end
    expect(page).to have_current_path(new_user_session_path)
  end
end

feature 'user login and assess features' do
  background do
    FactoryGirl.create(:user)
  end

  scenario 'navbar change according to user status' do
    visit '/'
    within('.navbar') do
      click_link 'Login'
    end
    expect(page).to have_current_path(new_user_session_path)
    within('#new_user') do
      fill_in 'user_email', with: 'sample@email.com'
      fill_in 'user_password', with: '!abcd1234'
      click_button 'Log in'
    end
    expect(page).to have_content 'Meal Preference'
    expect(page).to have_content 'Meal for the day'
    expect(page).to have_content 'Signed in as sample@email.com'
    expect(page).to have_content 'Logout'
    within('.navbar') do
      click_link 'Logout'
    end
    expect(page).to have_content 'Login'
  end
end