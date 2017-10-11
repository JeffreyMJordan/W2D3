require 'byebug'
module HandRankings 

  RANKINGS = [2,3,4,5,6,7,8,9,10,11,12,13,14]
  SUITS = [:diamonds, :clubs, :spades, :hearts]

  def of_kind?(amount) 
    RANKINGS.each do |rank| 
      return true if @cards.select{|card| card.rank==rank}.length==amount
    end
    false 
  end

  def full_house?
    of_kind?(2) && of_kind?(3)
  end

  def two_pair?
    hash = Hash.new(0)
    RANKINGS.each do |rank| 
      hash[rank] = @cards.select{|card| card.rank==rank}.length if @cards.select{|card| card.rank==rank}.length==2
    end
    hash.keys.length==2
  end

  def flush?
    SUITS.each do |suit| 
      return true if @cards.select{|card| card.suit==suit}.length==5
    end
    false 
  end

  def straight? 
    return false if @cards.length!=5 
    ordered_cards = @cards.sort_by{|card| card.rank}
    idx = 0 
    while idx<@cards.length-1
      return false if ordered_cards[idx].rank+1!=ordered_cards[idx+1].rank
      idx += 1 
    end
    true 
  end 

  def straight_flush? 
    straight? and flush? 
  end

  def ranking 
    if straight_flush? 
      9 
    elsif of_kind?(4)
      8 
    elsif full_house? 
      7 
    elsif flush? 
      6 
    elsif straight? 
      5 
    elsif of_kind?(3)
      4 
    elsif two_pair? 
      3 
    elsif of_kind?(2)
      2 
    else 
      1 
    end
        
  end

  def high_card 
    @cards.sort_by{|card| card.rank}.last
  end

  def high_card_rank 
    self.high_card.rank 
  end

end