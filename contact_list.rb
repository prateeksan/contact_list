require_relative 'contact'
require 'pry'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  COMMAND_LIST = ["Here is a List of Available Commands:", 
                  "new - create a new contact",
                  "list - list all contacts",
                  "show - show a contact",
                  "search - search contacts",
                  "q - quit"
                  ]

  def initialize
  end

  def print_command_list

    COMMAND_LIST.each do |command|
      puts command
    end
  end

  def create_contact
    puts "Enter Contact Name:"
    name = gets.chomp
    puts "Enter Contact Email:"
    email = gets.chomp
    Contact.create(name, email)
  end

  def list_all
    binding.pry
    puts Contact.all
  end

  def input_command
    puts "Enter a Command:"
    gets.chomp
  end

  def show_contact
    puts "Enter contact ID"
    id = gets.chomp.to_i
    puts Contact.find(id)
  end

  def search_contacts
    puts "Enter search term"
    term = gets.chomp
    puts Contact.search(term)
  end

  def main_loop
    while true
      print_command_list
      command = input_command
      create_contact if command == "new"
      list_all if command == "list"
      show_contact if command == "show"
      search_contacts if command == "search"
      break if command == "q"
    end
  end
end

contact_list = ContactList.new

contact_list.main_loop
