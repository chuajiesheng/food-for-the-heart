require 'rails_helper'

RSpec.describe Preference, type: :model do
  it { should belong_to :user }
end
