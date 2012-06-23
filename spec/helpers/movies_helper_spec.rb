require 'spec_helper'
describe MoviesHelper do
  describe "should return odd or even when given a count" do
    it "should return 'odd' when odd" do
      oddness(1).should == 'odd'  
    end
    it "should return 'even' when odd" do
      oddness(10).should == 'even'  
    end
  end
end
