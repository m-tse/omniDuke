require 'spec_helper'
require_relative '../../util/util'

describe Section do

  before do
    @section = FactoryGirl.create(:section)
  end


  subject { @section }

  it { should be_valid}

  #skipped all the useless validations of all the fields, they should all be there when it is created

  describe "pointer from section to course should work when link is created from section" do
    before do
      @course = FactoryGirl.create(:course)
      @section = FactoryGirl.create(:section)
      @section.course = @course
      @section.save
    end

    its(:course) {should == @course}
    

    it "and section should be pointed at by the course" do
      @course.sections.should include(@section)
    end
 

  end

  describe "pointer from section to course should work when link is created from course" do
    before do
      @course = FactoryGirl.create(:course)
      @section = FactoryGirl.create(:section)
      @course.sections<<@section
      @course.save
    end

    its(:course) { should == @course}
    it "and pointer from course to section should work as well" do
      @course.sections.should include(@section)
    end
  end
end

