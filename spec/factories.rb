FactoryGirl.define do

  factory :course do
    name "Computer Science 100"
    description "A really great class"
    credits 1
  end

  factory :section do
    suffix "01L"
    section_type "LEC"
    location "LSRC B101"
    enrollment 15
    capacity 100
    waitlist_enrollment 0
    waitlist_capacity 50
    class_number 100
  end

end
