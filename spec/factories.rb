FactoryGirl.define do

  factory :course do
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraphs
    credits 1
  end

  factory :section do
    suffix  Faker::Lorem.words(1)[0]
    section_type Faker::Lorem.words(1)[0]
    location  Faker::Address.secondary_address
    enrollment 15
    capacity 100
    waitlist_enrollment 0
    waitlist_capacity 50
    class_number 100
  end

end
