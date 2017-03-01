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

      it 'does not allow access another user preference' do
        get :new, id: 42
        expect(response).to have_http_status(:forbidden)
      end

      it 'should create a preference if there is none exist' do
        get :new, id: user.id
        expect(user.preference).to be
      end

      context 'when there is a preference created' do
        let!(:preference) { FactoryGirl.create(:preference, user: user)}

        it 'should not create a new preference' do
          expect { get :new, id: user.id }.to_not change { user.reload.preference }
        end
      end

      it 'should redirect to edit page for view/edit' do
        get :new, id: user.id
        expect(response).to redirect_to(preference_edit_user_path)
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
      let!(:preference) { FactoryGirl.create(:preference, user: user)}

      before do
        sign_in user
      end

      it 'allows authenticated access' do
        get :edit, id: user.id
        expect(response).to have_http_status(:success)
      end

      it 'does not allow access another user preference' do
        get :edit, id: 42
        expect(response).to have_http_status(:forbidden)
      end

      it 'assign the preference object' do
        get :edit, id: user.id
        expect(assigns(:preference)).to match(preference)
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
      let!(:preference) { FactoryGirl.create(:preference, user: user)}

      before do
        sign_in user
      end

      it 'does not allow access another user preference' do
        put :update, id: 42
        expect(response).to have_http_status(:forbidden)
      end

      it 'update the preference object' do
        params = {
            :id => user.id,
            :preference => {:chicken => '1', :mutton => '0', :beef => '0', :fish => '0', :prawn => '0', :squid => '0'}
        }
        expect { put :update, params }.to change { user.preference.reload.chicken? }
      end

      it 'should not accept random attribute' do
        params = {
            :id => user.id,
            :preference => {:chicken => '1', :mutton => '0', :beef => '0', :fish => '0', :prawn => '0', :squid => '0', :random => '123'}
        }
        expect { put :update, params: params }.to_not raise_error
      end
    end
  end
end
