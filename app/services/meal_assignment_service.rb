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
      if user.preference
        user.preference.to_array.each do |preference|
          if meals_left[preference] > 0
            meals_left[preference] -= 1
            Meal.create!(user: user, meal_availability: availability, meal_type: preference)
          end
        end
      else
        most_meals_left = meals_left.sort_by { |_key, value| value }.last

        meal_type = most_meals_left[0]
        meal_count = most_meals_left[1]

        if meal_count > 0
          meals_left[meal_type] -= 1
          Meal.create!(user: user, meal_availability: availability, meal_type: meal_type)
        end
      end
    end
  end
end