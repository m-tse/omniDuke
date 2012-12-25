require 'spec_helper'

describe SchedulatorController do

  describe "GET 'schedule'" do
    it "returns http success" do
      get 'schedule'
      response.should be_success
    end
  end

  describe "GET 'unschedule'" do
    it "returns http success" do
      get 'unschedule'
      response.should be_success
    end
  end

end
