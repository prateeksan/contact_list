require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
    @index = 0
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self 

    # Returns an Array of Contacts loaded from the database.
    def all
      puts "\n"
      CSV.foreach('contact_list.csv') do |csv|
        puts "ID: #{$.} \t Name: #{csv[0]} \t Email: #{csv[1]}"
      end
      puts "\n"
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      new_contact = Contact.new(name, email)
      update_csv(new_contact)
      puts "\n New Contact Created: \t Name: #{name} \t Email: #{email} \n"
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      puts "\n"
      csv = CSV.readlines('contact_list.csv')[id-1]
      puts (csv && (id != 0))? "ID: #{id} \t Name: #{csv[0]} \t Email: #{csv[1]}" : "Contact ID invalid."
      puts "\n"
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      term_found = false
      puts "\n"
      CSV.foreach('contact_list.csv') do |csv|
        if csv[0].match(/.*#{term}.*/) || csv[1].match(/.*#{term}.*/)
          puts "ID: #{$.} \t Name: #{csv[0]} \t Email: #{csv[1]}" 
          term_found = true
        end
      end
      puts "No matches in the databse..." if term_found == false
      puts "\n"
    end

    private

    def update_csv(new_contact)
      CSV.open('contact_list.csv', 'ab') do |csv|
        csv << [new_contact.name, new_contact.email]
      end
    end

  end

end
