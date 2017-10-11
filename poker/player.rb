require 'byebug'
require_relative 'hand'
class Player

  attr_accessor :name, :pot, :hand 

  def initialize(name, pot=100)
    @name=name
    @pot = pot
    @hand = Hand.new
  end

  def get_raise_amount
    puts "Enter how much you would like to raise by: "
    amount = gets.chomp.to_i
    @pot -= amount 
    amount 
  end

  def get_option 
    puts "#{@name}, would you like to (f)old, (c)heck, or (r)aise?"
    gets.chomp.downcase
  end

  def get_discards 
    puts "How many cards would you like to discard?"
    num = gets.chomp.to_i 
    indices = []
    num.times do 
      puts "Enter the index of the card you want to discard: "
      indices << gets.chomp.to_i
    end
    @hand.discard(indices)
  end

  def add_cards(cards)
    @hand.cards.concat(cards)
  end

  def update_pot(amount)
    @pot += amount
  end


end