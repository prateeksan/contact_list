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
                  "q - quit"
                  ]

  def initialize
  end

  def print_command_list

    COMMAND_LIST.each do |command|
      puts "\n#{command}"
    end
  end

  def create_contact
    puts "Enter Contact Name:"
    name = gets.chomp
    puts "Enter Contact Email:"
    email = gets.chomp
    contact = Contact.create(name, email)
    puts "\n New Contact Created: \t Name: #{contact.name} \t Email: #{contact.email} \n"
  end

  def list_all
    Contact.all.each_with_index do |contact, index|
      puts "\n ID: #{index + 1}\t Name: #{contact.name}\t Email: #{contact.email} \n"
    end
  end

  def input_command
    puts "Enter a Command:"
    gets.chomp
  end

  def show_contact
    puts "Enter contact ID"
    id = gets.chomp.to_i
    contact = Contact.find(id)
    if contact
      puts "\n ID: #{id} \t Name: #{contact.name} \t Email: #{contact.email}\n"
    end
  end

  def search_contacts
    puts "Enter search term"
    term = gets.chomp
    contacts = Contact.search(term)
    contacts.each do |contact|
      puts "\n Name: #{contact.name}\t Email: #{contact.email} \n"
    end
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
