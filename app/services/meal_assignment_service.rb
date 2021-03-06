class MealAssignmentService
  def generate_meal_availability(no_of_users)
    meals_count = (no_of_users - 5) + rand(5 * 2)
    availability = MealAvailability.create!(availability_for: Time.zone.now)

    ['chicken', 'mutton', 'beef', 'fish', 'prawn', 'squid'].each do |attr|
      break if meals_count < 1

      meal = rand(meals_count)
      availability.send("#{attr}=", meal)
      meals_count -= meal
    end

    availability.save!

    return availability
  end

  def meal_assignment(users)
    availability = MealAvailability.last
    meals_left = {
        'chicken' => availability.chicken,
        'mutton' => availability.mutton,
        'beef' => availability.beef,
        'fish' => availability.fish,
        'prawn' => availability.prawn,
        'squid' => availability.squid
    }
    users.each do |user|
      add_meal(availability, meals_left, user)
    end
  end

  private

  def add_meal(availability, meals_left, user)
    if user.preference
      user.preference.to_array.each do |preference|
        next if meals_left[preference] < 1

        meals_left[preference] -= 1
        Meal.create!(user: user, meal_availability: availability, meal_type: preference)
      end
    else
      meal_type, meal_count = meals_left.sort_by { |_key, value| value }.last
      return if meal_count < 1

      meals_left[meal_type] -= 1
      Meal.create!(user: user, meal_availability: availability, meal_type: meal_type)
    end
  end
end