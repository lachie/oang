require 'optparse'
require 'fileutils'

class CouchFixture
  include CouchMixin
  include FileUtils

  attr_accessor :filename, :query

  def self.run(argv=ARGV)
    OptionParser.new do |opt|
    end.parse!(argv)

    query = argv.shift
    raise "please specify a query" unless query

    filename = argv.shift
    raise "please specify a filename" unless filename

    new(query,filename).save!
  end

  def initialize(query,filename)
    @query = query
    @filename = filename
  end

  def self.uri
    @uri ||= 'http://'+CouchFixture.db(:oa_no_auth).uri
  end

  def self.uri_path(query)
    "#{uri}/#{query}"
  end

  def pull
    RestClient.get(uri_path)
  end

  def uri_path
    @uri_path ||= CouchFixture.uri_path(@query)
  end

  def path
    @path ||= File.join(Rails.root,'spec','fixtures','couch',@filename)
  end

  def save!
    mkdir_p File.dirname(path)
    value = pull

    if value.size > 0
      open(path,'w') {|f| f << value}
    end
  end
end
