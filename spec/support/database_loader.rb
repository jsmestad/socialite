configs = YAML.load_file(File.join(File.dirname(__FILE__), 'databases.yml'))
ActiveRecord::Base.configurations = configs

db_name = ENV['DB'] || 'sqlite'
ActiveRecord::Base.establish_connection(db_name)
ActiveRecord::Base.default_timezone = :utc

load_schema = lambda {
  # load File.join(File.dirname(__FILE__), "../dummy/db/schema.rb") # use db agnostic schema by default
  ActiveRecord::Migrator.up(File.join(File.dirname(__FILE__), '../../db/migrate')) # use migrations
}
silence_stream(STDOUT, &load_schema)

