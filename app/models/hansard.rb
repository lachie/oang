class Hansard
  include CouchMixin

  set_database_name :oa

  def self.dates
    database.view('hansard/by_date', :group => true)['rows'].map {|row| row['key']}
  end
end
