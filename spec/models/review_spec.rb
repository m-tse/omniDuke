require 'spec_helper'

describe Review do
  before do
    @review = FactoryGirl.create(:review)
  end

  subject { @review }

  it { should respond_to(:course)}
  it { should respond_to(:instructor)}
end
