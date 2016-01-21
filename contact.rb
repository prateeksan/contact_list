# Represents a person in an address book.
require 'csv'
require 'pry-byebug'
require 'pg'
require_relative 'setup'
class Contact < ActiveRecord::Base

  validates :name, :email, presence: true
  
  # attr_accessor :name, :email

  # def initialize(name, email)
  #   @name = name
  #   @email = email
  #   @index = 0
  # end

  # # Provides functionality for managing a list of Contacts in a database.
  # class << self 

  #   def connection
  #     @@connection = PG.connect(
  #       host: 'localhost',
  #       dbname: 'contacts',
  #       user: 'development',
  #       password: 'development'
  #     )
  #   end

  #   # Returns an Array of Contacts loaded from the database.
  #   def all
  #     puts "\n"
  #     connection.exec("SELECT * FROM contacts;").each do |row|
  #       puts "ID: #{row['id']} \t Name: #{row['name']} \t Email: #{row['email']}"
  #     end
  #     puts "\n"
  #   end

  #   # Creates a new contact, adding it to the database, returning the new contact.
  #   def create(name, email)
  #     connection.exec("INSERT INTO contacts (Name, Email) VALUES (\'#{name}\', \'#{email}\');")
  #     rows = connection.exec("SELECT * FROM contacts WHERE name = '#{name}' AND email = '#{email}'")
  #     rows = rows.values
  #     #new_contact = Contact.new(name, email)
  #     #update_csv(new_contact)
  #     puts "\n New Contact Created: \t Id: #{rows[-1][0]} \t Name: #{rows[-1][1]} \t Email: #{rows[-1][2]} \n"
  #   end

  #   # Returns the contact with the specified id. If no contact has the id, returns nil.
  #   def find(id)
  #     puts "\n"
  #     rows = connection.exec("SELECT * FROM contacts WHERE id = #{id};")
  #     #csv = CSV.readlines('contact_list.csv')[id-1]
  #     if rows.values != [] && (id != 0) 
  #       puts "ID: #{rows[0]['id']} \t Name: #{rows[0]['name']} \t Email: #{rows[0]['email']}"
  #       return true
  #     else
  #       puts "Contact ID invalid."
  #       return false
  #     end
  #     puts "\n"
  #   end

  #   # Returns an array of contacts who match the given term.
  #   def search(term)
  #     term_found = false
  #     puts "\n"
  #     query = connection.exec("SELECT * FROM contacts;") 
  #     query.each do |row|
  #       if row['name'].match(/.*#{term}.*/) || row['email'].match(/.*#{term}.*/)
  #         puts "ID: #{row['id']} \t Name: #{row['name']} \t Email: #{row['email']}" 
  #         term_found = true
  #       end
  #     end
  #     puts "No matches in the database..." if term_found == false
  #     puts "\n"
  #   end

  #   def delete(id)
  #     if find(id)
  #       puts "\n"
  #       puts "Are you sure you want to delete this contact? (Y/N)"
  #       confirmation = gets.chomp
  #       if confirmation == "Y"
  #         connection.exec("DELETE FROM contacts WHERE id = #{id};") 
  #         #csv = CSV.readlines('contact_list.csv')[id-1]
  #         puts "Contact deleted..."
  #       end
  #       puts "\n"
  #     end
  #   end
  #   #Rewrites the CSV file with all the database info
  #   def sync_csv
  #     query = connection.exec("SELECT * FROM contacts;")
  #     CSV.open('contact_list.csv', 'wb') do |csv|
  #       query.each do |row|
  #         csv << [row['name'], row['email']]
  #       end
  #     end
  #     puts "contacts synced"
  #   end

  # end

end
