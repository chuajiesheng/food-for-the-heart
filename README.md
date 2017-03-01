# Food for the heart

## Key features

1. Capture your meal preference (choose between chicken, mutton, beef, fish, prawn and squid).
2. Assign you a meal according to your preference.
3. Check what meal type you are assigned.

## Key technical decision

1. Devise is used (with no/minimum customisation) to reduce overhead when upgrade.
2. Capybara used to drive UI testing (instead of using view spec).
3. Minimum Gems used to reduce upgrade hell.
4. Email recovering is not configured until requested/required.

## Development Environment

- ruby 2.4.0
- rails 5.0.1

## Walkthough
(Alternative you can look at the feature spec, test as documentation)

1. Root hits the home page.
2. From here, you could either assign meals or login and become a user.
3. If you choose to assign meals, the system will assign meals for all the users in the system.
4. If you choose to login, please first sign up with your email and password (this is stored in our Postgres database).
5. After you sign up, please login with your email and password.
6. You could now indicate your meal preference either via the navigation bar or button on the user home page.
7. Choose between chicken, mutton, beef, fish, prawn and squid and save the form
8. You could also see what meal you are assign via the 'Meal of the day' link in the navigation bar.


## Code Walkthrough

1. HomeController
    - Serve home page
2. MealAssignmentController
    - Serve as the entry point to hit MealAssignmentService (where the business logic is stored)
3. MealController
    - Tell you what you are assigned
4. PreferenceController
    - Allow you to create, edit and update your meal preference
5. UserController
    - Serve as the entry point after login
6. MealAssignmentService
    - This is the business logic of assignment meals
    - Could be tested/change/evolve independent of Rails framework
    
## Heroku

Hosted at [Heroku](https://food-for-the-heart.herokuapp.com/)