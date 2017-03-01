require 'rails_helper'

RSpec.describe 'routes', :type => :routing do
  it 'routes / to home#index' do
    expect(:get => '/').to route_to(:controller => 'home', :action => 'index')
  end

  it 'routes /user/index to user#index' do
    expect(:get => '/user/index').to route_to(:controller => 'user', :action => 'index')
  end

  it 'routes /user/1/preference/new to preference#new' do
    expect(:get => '/user/1/preference/new').to route_to(:controller => 'preference', :action => 'new', :id => '1')
  end

  it 'routes /user/1/preference/edit to preference#edit' do
    expect(:get => '/user/1/preference/edit').to route_to(:controller => 'preference', :action => 'edit', :id => '1')
  end

  it 'routes /user/1/preference/update to preference#update' do
    expect(:put => '/user/1/preference/update').to route_to(:controller => 'preference', :action => 'update', :id => '1')
  end

  it 'routes /user/1/preference/ to preference#new' do
    expect(:get => '/user/1/preference/').to route_to(:controller => 'preference', :action => 'new', :id => '1')
  end

  it 'routes /user/1/meal/show to meal#new' do
    expect(:get => '/user/1/meal/show').to route_to(:controller => 'meal', :action => 'show', :id => '1')
  end

  it 'routes /user/1/meal to meal#new' do
    expect(:get => '/user/1/meal/').to route_to(:controller => 'meal', :action => 'show', :id => '1')
  end
end