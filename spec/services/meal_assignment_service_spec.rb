require 'rails_helper'

RSpec.describe 'MealAssignmentService' do
  before do
    srand(42)
  end

  describe '#generate_meal_availability' do
    let(:service) { MealAssignmentService.new }

    it 'generate a random meal availability record' do
      expect { service.generate_meal_availability(0) }.to change { MealAvailability.count }.by(1)
    end

    context 'it generate a random for each meal type' do
      it 'generate a minimum number of meals which is the number of user minus 5' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.total).to eq(10)
      end

      it 'generate 3 chicken' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.chicken).to eq(3)
      end

      it 'generate 4 mutton' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.mutton).to eq(4)
      end

      it 'generate 2 beef' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.beef).to eq(2)
      end

      it 'generate 0 fish' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.fish).to eq(0)
      end

      it 'generate 1 prawn' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.prawn).to eq(1)
      end

      it 'generate 0 squid' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.squid).to eq(0)
      end

      it 'save after generating all the meal' do
        meal_availability = service.generate_meal_availability(10)
        expect(meal_availability.reload.total).to eq(10)
      end
    end
  end

  describe '#meal_assignment' do
    it 'assign meal based on user preference' do
      service = MealAssignmentService.new
      user = FactoryGirl.create(:user)
      preference = FactoryGirl.create(:preference, user: user, chicken: true)

      service.generate_meal_availability(5)
      expect { service.meal_assignment([user]) }.to change { user.meals.count }.by(1)
    end

    it 'assign meal based on user preference' do
      service = MealAssignmentService.new
      user = FactoryGirl.create(:user)
      preference = FactoryGirl.create(:preference, user: user, chicken: true)

      service.generate_meal_availability(5)
      service.meal_assignment([user])
      expect(user.reload.meals.last.meal_type).to eq('chicken')
    end

    it 'assign meal based on user preference' do
      service = MealAssignmentService.new
      users = [FactoryGirl.create(:user), FactoryGirl.create(:user, email: 'new@email.com')]

      user_0_preference = FactoryGirl.create(:preference, user: users[0], chicken: true)
      user_1_preference = FactoryGirl.create(:preference, user: users[1], fish: true, prawn: true)

      service.generate_meal_availability(10)
      service.meal_assignment(users)
      expect(users[1].reload.meals.last.meal_type).to eq('prawn')
    end
  end
end