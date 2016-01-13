require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  @@all_contacts = []

  def initialize(name, email)
    @name = name
    @email = email
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    def sync_csv
      csv_file = CSV.open('contact_list.csv', 'w') do |csv| 
                   @@all_contacts.each_with_index do |contact, index|
                   csv << [index+1, contact.name, contact.email]
                 end
      end
      return 
    end

    # Returns an Array of Contacts loaded from the database.
    def all
      return @@all_contacts
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      new_contact = Contact.new(name, email)
      @@all_contacts << new_contact
      sync_csv
      return new_contact
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      @@all_contacts.length.times do |i|
        return @@all_contacts[i] if i+1 == id
      end
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      output = []
      @@all_contacts.each do |contact|
        output << contact if contact.name.match(/.*#{term}.*/) || contact.email.match(/.*#{term}.*/)
      end
      return output
    end

  end

end
