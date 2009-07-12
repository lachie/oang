class Hansard < CouchRest::Document
  include CouchMixin

  set_database_name :oa

  def self.find(id)
    get("hansard/#{id}")
  end

  def self.dates
    database.view('hansard/by_date', :group => true)['rows'].map {|row| [ Date.parse(row['key'][0]), row['key'][1] ]}
  end
end
