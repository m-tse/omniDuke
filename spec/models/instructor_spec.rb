require 'spec_helper'

describe Instructor do

  before do
    @instructor = Instructor.new(name:"Owen Astrachan")
  end

  subject { @instructor }
  it { should respond_to(:name)}
  it { should respond_to(:sections)}
  it { should respond_to(:formatted_name)}
  it { should be_valid }

  describe "when name is not present" do
    before { @instructor.name = " " }
    it { should_not be_valid }
  end

  describe "name should be lowercase after validation" do
    before do
      @instructor.name = "OWEN ASTRACHAN"
      @instructor.valid?
    end

    its(:name) {should == "owen astrachan"}
  end

  describe "formatted_name should display correctly" do
    before do
      @instructor=Instructor.create!(name:"asdf gfsd")
    end

    its(:formatted_name) {should == "Asdf Gfsd"}
  end

  describe "should not allow duplicate instructors with the same name" do
    before do
      newInstructor = Instructor.create!(name:"qwer")
      @instructor = Instructor.new(name:"qwer")
    end

    it{should_not be_valid}
  end
end
