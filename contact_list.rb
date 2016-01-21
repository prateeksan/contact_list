require_relative 'contact'
require 'pry-byebug'
require 'colorize'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  COMMAND_LIST = ["Here is a List of Available Commands:", 
                  "new - create a new contact",
                  "list - list all contacts",
                  "show - show a contact",
                  "search - search contacts",
                  "delete - delete contact",
                  #"sync - snyc csv",
                  "q - quit"
                  ]

  def main_loop
    while true
      print_command_list
      command = input_command
      if command == "new"
        create_contact 
      elsif command == "list"
        list_all
      elsif command == "show"
        show_contact
      elsif command == "search"
        search_contacts 
      elsif command == "delete"
        delete_contact 
      # elsif command == "sync"
      #   sync_csv 
      elsif command == "q"
        break 
      else
        puts "Invalid input, try again"
      end
    end
  end

  private

  def print_command_list
    puts "\n_______________________________________"
    puts "\n"
    COMMAND_LIST.each do |command|
      puts "#{command}"
    end
    puts "_______________________________________\n"
  end

  def create_contact
    puts "Enter Contact Name:"
    name = gets.chomp
    puts "Enter Contact Email:"
    email = gets.chomp
    Contact.create(name: name, email: email)
  end

  def list_all
    contacts = Contact.all
    display_contacts(contacts)
  end

  def input_command
    puts "Enter a Command:"
    gets.chomp
  end

  def show_contact
    begin
      puts "Enter contact ID"
      id = gets.chomp.to_i
      contact = Contact.find(id)
      display_contacts([contact])
    rescue ActiveRecord::RecordNotFound => e 
      puts e.message
    end
  end

  def search_contacts
    puts "Enter search term"
    term = gets.chomp
    pattern = "%#{term}%"
    contacts = Contact.where("name LIKE ? OR email LIKE ?", pattern, pattern)
    display_contacts(contacts)
  end

  def delete_contact
    begin
      puts "Enter Contact ID"
      id = gets.chomp.to_i
      contact = Contact.find(id)
      puts "Are you sure you want to delete the following contact (Y/N):"
      display_contacts([contact])
      confirmation = gets.chomp
      Contact.destroy(id) if confirmation == "Y"
    rescue ActiveRecord::RecordNotFound => e 
      puts e.message
    end
  end

  # def sync_csv
  #   Contact.sync_csv
  # end

  private

  def display_contacts(contacts)
    contacts.each do |contact|
      puts contact.id
      puts contact.name
      puts contact.email
      puts "\n"
    end
  end

end

contact_list = ContactList.new

contact_list.main_loop
