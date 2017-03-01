class MealAssignmentService
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
      user.preference.to_array.each do |preference|
        if meals_left[preference] > 0
          Meal.create!(user: user, meal_type: preference)
        end
      end
    end
  end
end