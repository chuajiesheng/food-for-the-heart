require 'rails_helper'

RSpec.describe PreferenceController, type: :controller do
  describe '#new' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        get :new, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'user signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it 'allows authenticated access' do
        get :new, id: 1
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#edit' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        get :edit, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'user signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it 'allows authenticated access' do
        get :edit, id: 1
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#update' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        put :update, id: 1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'user signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it 'allows authenticated access' do
        put :update, id: 1
        expect(response).to have_http_status(:success)
      end
    end
  end
end
