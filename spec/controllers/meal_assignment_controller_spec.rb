require 'rails_helper'

RSpec.describe MealAssignmentController, type: :controller do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    before do
      FactoryGirl.create(:preference, user: FactoryGirl.create(:user))
      FactoryGirl.create(:preference, user: FactoryGirl.create(:user, email: '1@email.com'))
      FactoryGirl.create(:preference, user: FactoryGirl.create(:user, email: '2@email.com'))
      FactoryGirl.create(:preference, user: FactoryGirl.create(:user, email: '3@email.com'))
    end

    it 'call MealAssignmentService to generate meal availability' do
      expect_any_instance_of(MealAssignmentService).to receive(:generate_meal_availability).with(4)
      get :index
    end
  end

end
