require 'pry-byebug'
require 'active_record'
require_relative 'contact'

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'contacts',
  username: 'development',
  password: 'development'
  )

puts 'CONNECTED'

#puts 'Setting up Database(recreating tables)...'

# ActiveRecord::Schema.define do
#   drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
#   create_table :contacts do |t|
#     t.column :name, :string
#     t.column :email, :string
#     t.timestamps null: false
#   end
# end
# puts 'Setup Done'