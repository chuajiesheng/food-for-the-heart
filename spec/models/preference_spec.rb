require 'rails_helper'

RSpec.describe Preference, type: :model do
  it { should belong_to :user }

  describe '#to_array' do
    it 'return an array of preference' do
      user = FactoryGirl.create(:user)
      preference = FactoryGirl.create(:preference, user: user, mutton: true, fish: true)

      expect(preference.to_array).to eq(['mutton', 'fish'])
    end
  end

end
