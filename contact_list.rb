require_relative 'contact'
require 'pry'
require 'colorize'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  COMMAND_LIST = ["Here is a List of Available Commands:", 
                  "new - create a new contact",
                  "list - list all contacts",
                  "show - show a contact",
                  "search - search contacts",
                  "delete - delete contact",
                  "sync - snyc csv",
                  "q - quit"
                  ]

  def initialize
  end

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
      elsif command == "sync"
        sync_csv 
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
    Contact.create(name, email)
  end

  def list_all
    Contact.all
  end

  def input_command
    puts "Enter a Command:"
    gets.chomp
  end

  def show_contact
    puts "Enter contact ID"
    id = gets.chomp.to_i
    Contact.find(id)
  end

  def search_contacts
    puts "Enter search term"
    term = gets.chomp
    Contact.search(term)
  end

  def delete_contact
    puts "Enter Contact ID"
    term = gets.chomp.to_i
    Contact.delete(term) 
  end

  def sync_csv
    Contact.sync_csv
  end

end

contact_list = ContactList.new

contact_list.main_loop
