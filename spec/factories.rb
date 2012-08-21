FactoryGirl.define do

  sequence :uniqueString do |n|
    Faker::Lorem.words(1).first+n.to_s
  end

  sequence :uniqueName do |n|
    Faker::Name.name + n.to_s
  end

  factory :instructor do
    name {generate(:uniqueName)}
  end

  factory :session do
    season ["spring", "summer", "fall", "winter"].sample
    year {rand(10)+2000}
  end
  factory :course do
    name Faker::Lorem.sentence
    new_number {rand(100)+1}
    old_number {rand(300)+1}
  end

  factory :section do
    location  Faker::Address.secondary_address
    room Faker::Address.secondary_address
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

  factory :course_attribute do
    scrape_value ["Seminar", "(CCI) Cross Cultural Inquiry", "First Year Students Only", "(SS) Social Sciences", "(ALP) Arts, Literature & Performance", "(CZ) Civilizations", "(NS) Natural Sciences", "(QS) Quantitative Studies", "(EI) Ethical Inquiry", "(STS) Science, Technology, and Society", "(FL) Foreign Language", "(R) Research", "(W) Writing", "Service Learning Course", "Seminar"].sample
  end

  factory :subject do
    abbr {generate(:uniqueString)}
    name {generate(:uniqueString)}
  end
end
