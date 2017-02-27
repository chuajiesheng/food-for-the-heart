require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  it 'displays the link to user login' do
    render
    expect(rendered).to include('Login')
  end
end
