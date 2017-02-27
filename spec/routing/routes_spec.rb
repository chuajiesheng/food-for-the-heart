require 'rails_helper'

RSpec.describe 'routes', :type => :routing do
  it 'routes / to home#index' do
    expect(:get => '/').to route_to(:controller => 'home', :action => 'index')
  end
end