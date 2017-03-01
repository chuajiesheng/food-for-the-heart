class MealAssignmentService
  def initialize

  end

  def generate_meal_availability
    MealAvailability.create!
  end
end