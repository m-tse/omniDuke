require 'spec_helper'

describe Instructor do

  before do
    @instructor = Instructor.new(name:"Owen Astrachan")
  end

  subject { @instructor }
  it { should be_valid }



  describe "should not allow duplicate instructors with the same name" do
    before do
      newInstructor = Instructor.create!(name:"qwer")
      @instructor = Instructor.new(name:"qwer")
    end

    it{should_not be_valid}
  end

end
