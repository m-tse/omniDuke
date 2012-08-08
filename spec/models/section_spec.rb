require 'spec_helper'
require_relative '../../util/util'

describe Section do

  before do
    @section = FactoryGirl.create(:section)
  end


  subject { @section }
  it { should respond_to(:instructors)}
  it { should respond_to(:course)}
  it { should respond_to(:time_slot)}
  it { should be_valid}

  #skipped all the useless validations of all the fields, they should all be there when it is created

  describe "pointer to course should work" do
    before do
      @course = FactoryGirl.create(:course)
    end
  end

end

