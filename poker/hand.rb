require_relative 'hand_rankings'
class Hand 

  include HandRankings 
  attr_accessor :cards

  def initialize(cards = [])
    @cards = cards
  end

  def add_card(card)
    @cards << card
  end

  def discard(indices) 

    if indices.any?{|idx| idx<0 or idx>5}
      puts "Those indices aren't valid"
      return 
    end

    if indices.length>3 
      puts "You can only discard up to three cards"
      return 
    end

    discarded = []
    indices.each do |idx| 
      discarded << @cards[idx]
    end
    discarded.each do |card| 
      @cards.delete(card)
    end
    discarded
  end

  def length 
    @cards.length
  end

  #I can just have a simple switch for hands of different ranks
  #How do I do tiebreakers? 
  def beats_hand?(other_hand)
    return true if self.ranking>other_hand.ranking
    return false if self.ranking<other_hand.ranking 
    return true if self.high_card.rank>other_hand.high_card.rank
    return false if self.high_card.rank<other_hand.high_card.rank
  end



end