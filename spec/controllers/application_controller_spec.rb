require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'after login' do
    it 'returns redirect to user#index' do
      controller.after_sign_in_path_for(@user).should == user_index_path
    end
  end
end
