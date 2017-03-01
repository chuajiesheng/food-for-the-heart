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

    return availability
  end
end