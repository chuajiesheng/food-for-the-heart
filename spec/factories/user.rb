FactoryGirl.define do
  factory :user do
    email 'sample@email.com'
    password '!abcd1234'

    # if needed
    # is_active true
  end
end