require 'rails_helper'

RSpec.describe PreferenceController, type: :controller do
  describe '#new' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        get :new, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe 'user signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      it 'does not allow access another user preference' do
        get :new, params: { id: 42 }
        expect(response).to have_http_status(:forbidden)
      end

      it 'should create a preference if there is none exist' do
        get :new, params: { id: user.id }
        expect(user.preference).to be
      end

      context 'when there is a preference created' do
        let!(:preference) { FactoryGirl.create(:preference, user: user)}

        it 'should not create a new preference' do
          expect { get :new, params: { id: user.id }}.to_not change { user.reload.preference }
        end
      end

      it 'should redirect to edit page for view/edit' do
        get :new, params: { id: user.id }
        expect(response).to redirect_to(preference_edit_user_path)
      end
    end
  end

  describe '#edit' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        get :edit, params: { id: 1 }
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
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end

      it 'does not allow access another user preference' do
        get :edit, params: { id: 42 }
        expect(response).to have_http_status(:forbidden)
      end

      it 'assign the preference object' do
        get :edit, params: { id: user.id }
        expect(assigns(:preference)).to match(preference)
      end
    end
  end

  describe '#update' do
    describe 'user not signed in' do
      it 'blocks unauthenticated access' do
        put :update, params: { id: 1 }
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
        put :update, params: { id: 42 }
        expect(response).to have_http_status(:forbidden)
      end

      it 'update the preference object' do
        params = {
            :id => user.id,
            :preference => {:chicken => '1', :mutton => '0', :beef => '0', :fish => '0', :prawn => '0', :squid => '0'}
        }
        expect { put :update, params: params }.to change { user.preference.reload.chicken? }
      end

      it 'should not accept random attribute' do
        params = {
            :id => user.id,
            :preference => {:chicken => '1', :mutton => '0', :beef => '0', :fish => '0', :prawn => '0', :squid => '0', :random => '123'}
        }
        expect { put :update, params: params }.to_not raise_error
      end

      it 'should tell the user that is updated' do
        params = {
            :id => user.id,
            :preference => {:chicken => '1', :mutton => '0', :beef => '0', :fish => '0', :prawn => '0', :squid => '0', :random => '123'}
        }
        put :update, params: params
        expect(flash[:notice]).to eq('Preference updated')
      end

      context 'when preference is not created' do
        let!(:preference) { nil }

        it 'redirect the user to new path' do
          params = {
              :id => user.id,
              :preference => {:chicken => 'some junk', :mutton => '10', :beef => '0', :fish => '0', :prawn => '0', :squid => '0'}
          }
          put :update, params: params
          expect(response).to redirect_to(preference_new_user_path)
        end
      end
    end
  end
end
