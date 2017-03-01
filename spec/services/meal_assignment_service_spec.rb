require 'rails_helper'

RSpec.describe 'MealAssignmentService' do
  describe 'generate random meal amount' do
    let(:service) { MealAssignmentService.new }

    it 'generate a random meal availability record' do
      expect { service.generate_meal_availability(0) }.to change { MealAvailability.count }.by(1)
    end

    context 'it generate a random for each meal type' do
      before do
        srand(42)
      end

      it 'generate a minimum number of meals which is the number of user minus 5' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.total).to eq(10)
      end

      it 'generate 3 chicken' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.chicken).to eq(3)
      end

      it 'generate 4 mutton' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.mutton).to eq(4)
      end

      it 'generate 2 beef' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.beef).to eq(2)
      end

      it 'generate 0 fish' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.fish).to eq(0)
      end

      it 'generate 1 prawn' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.prawn).to eq(1)
      end

      it 'generate 0 squid' do
        no_of_users = 10
        meal_availability = service.generate_meal_availability(no_of_users)
        expect(meal_availability.squid).to eq(0)
      end
    end


  end
end