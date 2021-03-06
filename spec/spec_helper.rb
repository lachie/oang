# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'

require 'pp'

$pull_fixtures = true

FakeWeb.allow_net_connect = false

module FixtureHelper
  def fixture_path(*name)
    File.join(File.dirname(__FILE__),'fixtures',*name)
  end

  def fake_couch(id, params={})
    query = id

    unless params.empty?
      query += "?#{params.to_query}"
    end

    query_file = query.sub('?','_Q_').gsub(/[^A-Za-z0-9]+/,'_').sub(/^_/,'').sub(/_$/,'')
    query_file += '.js'

    fix = CouchFixture.new(query,query_file)
    
    puts fix.uri_path

    if $pull_fixtures && ! File.exist?(fix.path)
      fix.save!
    end

    FakeWeb.register_uri(:get, fix.uri_path, :file => fix.path)
  end

end

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner

  config.include FixtureHelper
end
