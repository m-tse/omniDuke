require 'spec_helper'

describe Course do

  before do
    @course = Course.new(name:"CompSci 100")
  end

  subject { @course }
  it { should respond_to(:name)}
  it { should respond_to(:session_id)}
  it {should respond_to(:prerequisites)}
  it { should respond_to(:sections)}
  it { should respond_to(:instructors)}
  it { should respond_to(:subject)}
  it {should resopnd_to(:old_number)}
  it { should respond_to(:new_number)}
  it { should be_valid}
end
