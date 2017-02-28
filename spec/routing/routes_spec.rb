require 'rails_helper'

RSpec.describe 'routes', :type => :routing do
  it 'routes / to home#index' do
    expect(:get => '/').to route_to(:controller => 'home', :action => 'index')
  end

  it 'routes /user/index to user#index' do
    expect(:get => '/user/index').to route_to(:controller => 'user', :action => 'index')
  end
end