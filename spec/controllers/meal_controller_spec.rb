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
    end
  end
end
