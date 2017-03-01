require 'rails_helper'

RSpec.describe MealController, type: :controller do
  describe 'GET #show' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        get :show, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'user is signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it 'returns http success' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it 'does not allow access another user preference' do
        get :show, params: { id: 42 }
        expect(response).to have_http_status(:forbidden)
      end

      context 'when assigned a meal' do
        let(:meal_availability) { FactoryGirl.create(:meal_availability) }
        let!(:meal) { FactoryGirl.create(:meal, user: user, meal_availability: meal_availability, meal_type: 'chicken')}

        it 'assign meal object to display' do
          get :show, params: { id: user.id }
          expect(assigns(:meal)).to match(meal)
        end
      end

      it 'dont assign meal object if there is none' do
        get :show, params: { id: user.id }
        expect(assigns(:meal)).to be_nil
      end

    end
  end
end
