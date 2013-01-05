require 'spec_helper'

describe Course do

  before do
    @course = Course.new(name:"CompSci 100")
  end

  subject { @course }

end
