require 'spec_helper'

describe Session do

  before do
    @session = Session.new(season:"spring", year: 2013)
  end

  subject { @session }
  it {should respond_to(:season)}
  it { should respond_to(:name)}
  it { should respond_to(:year)}
  it { should be_valid}

  describe "when season is not present" do
    before {@session.season = " " }
    it { should_not be_valid}
  end

  describe "when year is not present" do
    before {@session.year = nil }
    it { should_not be_valid}
  end

  describe "when season is not an included season string" do
    before { @session.season = " asdfasdf"}
    it { should_not be_valid}
  end

  describe "when session already exists" do
    before do
      sameSession = @session.dup
      sameSession.save
    end

    it { should_not be_valid }
  end

  describe "same year but different season should work" do
    before do
      @session.season = "spring"
      @session.year = 2012
      sameSession = @session.dup
      sameSession.save
      @session.season="fall"
    end

    it { should be_valid}
  end

  describe "name should correctly concatenate season and year" do
    before do
      @session.valid?
    end

    its(:name) { should == @session.season+@session.year.to_s}
  end

end
