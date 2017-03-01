RSpec.describe 'MealAssignmentService' do
  describe 'generate random meal amount' do
    let(:service) { MealAssignmentService.new }

    it 'generate a random meal availability record' do
      expect { service.generate_meal_availability(0) }.to change { MealAvailability.count }.by(1)
    end

    it 'generate a minimum number of meals which is the number of user minus 5' do
      no_of_users = 10
      meal_availability = service.generate_meal_availability(no_of_users)
      expect meal_availability.total > 5
    end
  end
end