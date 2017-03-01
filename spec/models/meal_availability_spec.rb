require 'rails_helper'

RSpec.describe MealAvailability, type: :model do
  describe '#total' do
    let(:meal) { FactoryGirl.create(:meal_availability) }

    it 'return the total across all the meals' do
      expect(meal.total).to eq(6)
    end
  end

  describe 'before_create' do
    it 'set chicken meal type to be zero' do
      meal_availability = MealAvailability.create!
      expect(meal_availability.chicken).to eq(0)
    end

    it 'set mutton meal type to be zero' do
      meal_availability = MealAvailability.create!
      expect(meal_availability.mutton).to eq(0)
    end

    it 'set beef meal type to be zero' do
      meal_availability = MealAvailability.create!
      expect(meal_availability.beef).to eq(0)
    end

    it 'set fish meal type to be zero' do
      meal_availability = MealAvailability.create!
      expect(meal_availability.fish).to eq(0)
    end

    it 'set prawn meal type to be zero' do
      meal_availability = MealAvailability.create!
      expect(meal_availability.prawn).to eq(0)
    end

    it 'set squid meal type to be zero' do
      meal_availability = MealAvailability.create!
      expect(meal_availability.squid).to eq(0)
    end

  end
end
