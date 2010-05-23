require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'active_record'
require 'active_record/fixtures'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'embedded_url'
 
# establish the database connection
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection('embedded_url_test')
 
# load the schema ... silently
ActiveRecord::Migration.verbose = false
load(File.dirname(__FILE__) + "/schema.rb")
 
# load the ActiveRecord models
require File.dirname(__FILE__) + '/models/item.rb'

class Test::Unit::TestCase
end

