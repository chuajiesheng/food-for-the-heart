require 'rails_helper'

describe 'home page', :type => :feature do
  it 'show me two links, login and assign meals' do
    visit '/'
    expect(page).to have_content 'Login'
    expect(page).to have_content 'Assign Meals'
  end

  it 'login redirect me to devise login page' do
    visit '/'
    click_link 'Login'
    expect(page).to have_current_path(new_user_session_path)
  end
end