require File.dirname(__FILE__)+'/../spec_helper'

describe CouchMixin do
  before do
    class CMFix
      include CouchMixin
      set_database_name :oa
    end
  end

  it "has a database" do
    CMFix.database.should be_instance_of(CouchRest::Database)
  end
end

