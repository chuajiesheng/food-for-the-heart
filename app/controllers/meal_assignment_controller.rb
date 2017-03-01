class MealAssignmentController < ApplicationController
  def index
    service = MealAssignmentService.new
    service.generate_meal_availability(User.count)
  end
end
