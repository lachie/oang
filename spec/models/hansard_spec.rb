require File.dirname(__FILE__)+'/../spec_helper'

describe Hansard do
  describe ".dates" do
    before do
      fake_couch('_design/hansard/_view/by_date', :group => true)
    end

    it "returns dates" do
      Hansard.dates.should == [ ['2009/06/04','representatives'] ]
    end
  end
end
