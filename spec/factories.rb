FactoryGirl.define do
  factory :user do
    first_name 'First'
    sequence(:surname) { |n| "Surname_#{n}" }
    sequence(:email) { |n| "user_#{n}@da-silva.me.uk" }
    password "password"
    password_confirmation "password"
    admin false
  end

  factory :event do
    title 'Test Event'
    start_date DateTime.now
    end_date DateTime.now
    where 'Location description'
    post_map_ref 'ET1 3ST'
    public_description 'A public description'
    organiser_id 1
    # fee
    # user_id 1
    featured_event false
    # approved
    # show_to_users
  end
end