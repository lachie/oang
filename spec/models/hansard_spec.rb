require File.dirname(__FILE__)+'/../spec_helper'

describe Hansard do
  describe ".dates" do
    before do
      fake_couch('_design/hansard/_view/by_date', :group => true)
    end

    it "returns dates" do
      Hansard.dates.should == [ [Date.parse('2009-06-04'),'houses/federal/representatives'] ]
    end
  end

  describe ".find" do
    before do
      fake_couch("hansard%2Ffederal%2Frepresentatives%2F2009-06-04")
    end

    it "returns the hansard" do
      Hansard.find('federal/representatives/2009-06-04')
    end
  end
end
