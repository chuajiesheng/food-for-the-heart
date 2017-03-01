class MealAssignmentService
  def initialize

  end

  def generate_meal_availability(no_of_users)
    meals_count = (no_of_users - 5) + rand(5 * 2)
    availability = MealAvailability.create!(availability_for: Time.zone.now)

    ['chicken', 'mutton', 'beef', 'fish', 'prawn', 'squid'].each do |attr|
      meal = rand(meals_count)
      availability.send("#{attr}=", meal)
      meals_count -= meal
    end

    availability.save!

    return availability
  end

  def meal_assignment(users)
    users[0].meals = [Meal.create!(user: users[0], meal_type: 'chicken')]
  end
end