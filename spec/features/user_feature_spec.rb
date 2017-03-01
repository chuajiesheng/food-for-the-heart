require 'rails_helper'

feature 'user login and assess features' do
  background do
    @user = FactoryGirl.create(:user)
  end

  scenario 'able to indicate my preference' do
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
  end
end