class MealAssignmentController < ApplicationController
  def index
    service = MealAssignmentService.new
    @meal_availability = service.generate_meal_availability(User.count)
    service.meal_assignment(User.all)
  end
end
