require 'rails_helper'

describe 'home page', :type => :feature do
  it 'show me two links, login and assign meals' do
    visit '/'
    expect(page).to have_content 'Login'
    expect(page).to have_content 'Assign Meals'
  end
end