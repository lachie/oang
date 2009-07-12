class Section
  include CouchMixin

  set_database_name :oa

  def find(id)
    raw_view('')
  end
end

