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

  factory :review do
    assignment_easiness 7
    test_easiness 6
    helpfulness 5
    clarity 7
    enthusiasm 6
    course_content 8
    textbook_usefulness 10
    review_content Faker::Lorem.paragraph

  end
end
