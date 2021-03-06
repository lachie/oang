require 'pp'
module CouchMixin
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      #cattr_accessor :database
    end
  end

  # def method_missing(method_symbol, *arguments)
  #   method_name = method_symbol.to_s

  #   case method_name[-1..-1]
  #   when "="
  #     self[method_name[0..-2]] = arguments.first
  #   when "?"
  #     !! self[method_name[0..-2]]
  #   else
  #     # Returns nil on failure so forms will work
  #     key?(method_name) ? self[method_name] : nil
  #   end
  # end


  module ClassMethods
    def set_database_name(name)
      self.database = db(name)
    end

    def db_configs
      @db_configs ||= YAML.load_file( "#{Rails.root}/config/couchdb.yml" ).with_indifferent_access
    end

    def db(database_name)
      case database_name
      when Symbol
        env_config = db_configs[Rails.env] || raise("No CouchDB config found for #{Rails.env} environment")
        full_url_to_database = env_config[database_name] || raise("No CouchDB config called '#{database_name}' for env #{Rails.env}")
      when String
        full_url_to_database = database_name
        if full_url_to_database !~ /^http:\/\//
          full_url_to_database = "http://localhost:5984/#{database_name}"
        end
      end

      CouchRest.database!(full_url_to_database)
    end

    def raw_view(view_name, options={})
      database.view(view_name,options)
    end

    def get(id,options={})
      new(database.get(id,options))
    end
  end
end
