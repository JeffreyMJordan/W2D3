class Card 

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank 
    @suit = suit 
  end

  def to_s 
    "[#{rank}#{SUIT_HASH[@suit]}]"
  end

  SUIT_HASH = {:diamonds => "D", :spades => "S", :hearts => "H", :clubs => "C"}

end