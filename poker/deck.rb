require_relative 'card.rb'
class Deck 

  attr_reader :cards

  def initialize 
    @cards = populate 
  end

  def populate 
    cards = []
    [:diamonds, :hearts, :spades, :clubs].each do |suit| 
      [2,3,4,5,6,7,8,9,10,11,12,13,14].each do |rank| 
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end

  def draw(n)
    res = []
    n.times do 
      res << @cards.pop
    end
    res 
  end

  def shuffle! 
    @cards.shuffle!
  end

  def add(card)
    @cards << card
  end
end