require 'rails_helper'

feature 'complete user features' do
  background do
    @user = FactoryGirl.create(:user)
  end

  scenario 'indicate preference and assign meal' do
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
    expect(page).to have_current_path(user_index_path)
    within('.jumbotron') do
      click_link 'Meal Preference'
    end
    expect(page).to have_current_path(preference_edit_user_path(id: @user.id))
    within('.edit_preference') do
      check('Mutton')
      check('Prawn')
      click_button('Update Preference')
    end
    expect(page.has_checked_field?('Mutton'))
    expect(page.has_checked_field?('Prawn'))
    within('.navbar') do
      click_link 'Food for the heart'
    end
    within('.jumbotron') do
      click_link 'Assign Meals'
    end
    expect(page).to have_current_path(meal_assignment_index_path)
    expect(page).to have_content 'Meal Availability'
    expect(page).to have_content 'Meal Assignment'
    within('.navbar') do
      click_link 'Meal for the day'
    end
    expect(page).to have_content 'Assigned Meal'
  end
end