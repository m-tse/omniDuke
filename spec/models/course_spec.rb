require 'spec_helper'

describe Course do

  before do
    @course = Course.new(name:"CompSci 100", description:"a description", credits:1)
  end

  subject { @course }
  it { should respond_to(:name)}
  it { should respond_to(:description)}
  it { should respond_to(:credits)}
  it { should respond_to(:synopsis)}
  it { should respond_to(:seminar)}
  it { should respond_to(:session_id)}
  it {should respond_to(:prerequisites)}
  it { should respond_to(:sections)}
  it { should respond_to(:instructors)}
  it { should respond_to(:modes_of_inquiry)}
  it { should respond_to(:areas_of_knowledge)}
  it { should respond_to(:course_numberings)}
  it { should respond_to(:subjects)}
  it { should be_valid}
end
