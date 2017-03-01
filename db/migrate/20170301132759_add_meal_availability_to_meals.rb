class AddMealAvailabilityToMeals < ActiveRecord::Migration[5.0]
  def change
    add_reference :meals, :meal_availability, index: true
  end
end
