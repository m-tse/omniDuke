require 'spec_helper'

describe Course do

  before do
    @course = Course.new(name:"CompSci 100")

  end

  subject { @course }
  it {should be_valid}

  describe "section links should function correctly" do
    before do
      @section = FactoryGirl.create(:section)
      @course.sections<<@section
      @section.save
      @course.save
    end
    its(:sections) {should include(@section)}

  end
end
