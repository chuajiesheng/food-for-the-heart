require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe 'GET #index' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'user signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it 'allows authenticated access' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
