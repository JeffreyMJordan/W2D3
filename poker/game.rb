require_relative 'player'
require_relative 'deck'
require 'byebug'
class Game 

  attr_accessor :deck, :players

  def initialize(deck, players)
    @deck = deck 
    @players = players 
    @ante = 10
  end

  def play_round 
    zero_cards
    round_players = @players.dup 
    deal 
    render
    pot = 0
    pot += get_bets(round_players, @ante)
    get_discards(round_players)
    render
    pot += get_bets(round_players)
    winner = determine_winner(round_players)
    winner.update_pot(pot)
    remove_broke_players
  end

  def zero_cards 
    @players.each do |player| 
      player.hand = Hand.new
    end
  end

  def determine_winner(players)
    hash = Hash.new{|h,k| h[k] = []}
    players.each do |player| 
      hash[player.hand.ranking] << player
    end
    highest = hash.keys.sort.last 

    if hash[highest].length>=2 
      tiebreaker_players = hash[highest]
      high_card_rank = 0 
      winning_player = nil 
      tiebreaker_players.each do |player| 
        if player.hand.high_card_rank > high_card_rank
          high_card_rank = player.hand.high_card_rank
          winning_player = player 
        end
      end
      winning_player
    else 
      return hash[highest].last 
    end
  end

  def remove_broke_players
    players_dup = @players.dup 
    @players.each do |player| 
      if player.pot<=0 
        players_dup.delete(player)
      end
    end
    @players = players_dup 
  end

  def over? 
    @players.length==1
  end

  def get_discards(players)
    players.each do |player| 
      discarded = player.get_discards
      player.add_cards(@deck.draw(discarded.length))
      discarded.each{|card| @deck.add(card)}
      @deck.shuffle!
    end
  end


  def deal 
    @players.each do |player| 
      player.add_cards(@deck.draw(5))
    end 
  end   

  def get_bets(players, round_ante=0 )
    no_raises = false
    round_total = 0 
    puts "Ante: #{round_ante}"
    until no_raises 
      #byebug
      no_raises = true 
      folders = []
      players.each do |player| 
        option = player.get_option
        if option == "r" 
          no_raises = false 
          amount = player.get_raise_amount
          player.update_pot(round_ante*-1)
          round_ante += amount 
          round_total += round_ante
          puts "Ante: #{round_ante}"
        elsif option == "c" 
          player.update_pot(round_ante*-1)
          round_total += round_ante
        elsif option == "f" 
          folders << player
        end
      end
      round_ante = 0 
      players = players.select{|player| !folders.include?(player)}
    end
    round_total
  end

  def play 
    until over? 
      play_round
    end
    puts "#{@players.last.name} won!"
  end

  def render 
    str = ""
    @players.each do |player| 
      str += "#{player.name}'s cards: "
      player.hand.cards.each do |card| 
        str += card.to_s + " "
      end
      str += "#{player.name}'s pot: #{player.pot}\n"
    end
    puts str 
    str 
  end

end

if __FILE__==$0 
  game = Game.new(Deck.new, [Player.new("John"), Player.new("Jack")]) 
  game.play
end





