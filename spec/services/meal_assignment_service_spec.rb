RSpec.describe 'MealAssignmentService' do
  describe 'generate random meal amount' do
    let(:service) { MealAssignmentService.new }

    it 'generate a random meal availability record' do
      expect { service.generate_meal_availability }.to change { MealAvailability.count }.by(1)
    end
  end
end