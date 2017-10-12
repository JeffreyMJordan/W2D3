require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require_relative 'game'

describe "card" do 

  subject(:card){Card.new(10, :diamonds)}

  it "initializes with a rank and suit" do 
    expect(card.rank).to eq(10)
    expect(card.suit).to eq(:diamonds)
  end

  it "returns the correct string representation" do 
    expect(card.to_s).to eq("[10D]")
  end
end

describe "deck" do 
  subject(:deck){Deck.new}

  it "deck has 52 cards" do 
    expect(deck.cards.length).to eq(52)
  end

  it "has 13 cards of every suit" do 
    expect(deck.cards.select{|card| card.suit==:diamonds}.length).to eq(13)
    expect(deck.cards.select{|card| card.suit==:hearts}.length).to eq(13)
    expect(deck.cards.select{|card| card.suit==:spades}.length).to eq(13)
    expect(deck.cards.select{|card| card.suit==:clubs}.length).to eq(13)
  end

  it "has 4 cards of every rank" do 
    [2,3,4,5,6,7,8,9,10,11,12,13,14].each do |rank| 
      expect(deck.cards.select{|card| card.rank==rank}.length).to eq(4)
    end
  end

  it "\'draw\' returns appropriate number of cards" do 
    expect(deck.draw(2).length).to eq(2)
    expect(deck.cards.length).to eq(50)
  end

  it "\'shuffle!\' shuffles cards" do 
    expect(deck.cards).to receive(:shuffle!)
    deck.shuffle!
  end

  it "\'add\' adds card to deck" do 
    card = Card.new(15, :spades)
    deck.add(card)
    expect(deck.cards.length).to eq(53)
    expect(deck.cards.include?(card)).to eq(true)
  end

end

describe 'hand' do 
  it "initializes with empty array" do 
    hand = Hand.new 
    expect(hand.cards).to eq([])
  end 

  it "initializes with passed in cards" do 
    cards = [Card.new(10, :clubs)] 
    hand = Hand.new(cards)
    expect(hand.cards).to eq(cards)
  end

  it "adds cards correctly" do 
    hand = Hand.new([Card.new(10, :clubs)])
    expect(hand.cards.length).to eq(1)
    hand.add_card(Card.new(10, :spades))
    expect(hand.cards.length).to eq(2)
  end

  it "discards cards correctly" do 
    hand = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(14, :spades)])
    expect(hand.discard([0,1,2]).length).to eq(3)
    expect(hand.cards.length).to eq(2)
  end

  describe "two_of_kind" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(10, :clubs)])
      expect(hand.of_kind?(2)).to eq(false)
      hand.add_card(Card.new(10, :spades))
      expect(hand.of_kind?(2)).to eq(true)
    end
  end

  describe "three_of_kind" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(10, :clubs)])
      expect(hand.of_kind?(3)).to eq(false)
      hand.add_card(Card.new(10, :spades))
      expect(hand.of_kind?(3)).to eq(false)
      hand.add_card(Card.new(10, :hearts))
      expect(hand.of_kind?(3)).to eq(true)
    end
  end

  describe "four_of_kind" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(10, :clubs)])
      expect(hand.of_kind?(4)).to eq(false)
      hand.add_card(Card.new(10, :spades))
      expect(hand.of_kind?(4)).to eq(false)
      hand.add_card(Card.new(10, :hearts))
      expect(hand.of_kind?(4)).to eq(false)
      hand.add_card(Card.new(10, :diamonds))
      expect(hand.of_kind?(4)).to eq(true)
    end
  end

  describe "full_house" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(10, :clubs), Card.new(10, :hearts), Card.new(10, :spades)])
      expect(hand.full_house?).to eq(false)
      hand.add_card(Card.new(11, :clubs))
      hand.add_card(Card.new(11, :spades))
      expect(hand.full_house?).to eq(true)
    end
  end

  describe "two_pair" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(10, :clubs), Card.new(10, :hearts)])
      expect(hand.two_pair?).to eq(false)
      hand.add_card(Card.new(11, :clubs))
      hand.add_card(Card.new(11, :clubs))
      expect(hand.two_pair?).to eq(true)
    end
  end

  describe "flush" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(10, :spades), Card.new(10, :spades), Card.new(10, :spades), Card.new(10, :spades)])
      expect(hand.flush?).to eq(false)
      hand.add_card(Card.new(10, :spades))
      expect(hand.flush?).to eq(true)
    end
  end

  describe "straight" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades)])
      expect(hand.straight?).to eq(false)
      hand.add_card(Card.new(14, :spades)) 
      expect(hand.straight?).to eq(true)
    end
  end

  describe "straight_flush" do 
    it "returns true and false appropriately" do 
      hand = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades)])
      expect(hand.straight_flush?).to eq(false)
      hand.add_card(Card.new(14, :spades)) 
      expect(hand.straight_flush?).to eq(true)
    end
  end

  describe "beats_hand?" do 
    it "returns true and false for hands of different rankings" do 
      hand1 = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(14, :spades)])
      hand2 = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(9, :hearts)])
      expect(hand1.beats_hand?(hand2)).to eq(true)
      expect(hand2.beats_hand?(hand1)).to eq(false)
    end

    it "returns true and false when need high-card tiebreaker" do 
      hand1 = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(14, :spades)])
      hand2 = Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(9, :spades)])
      expect(hand1.beats_hand?(hand2)).to eq(true)
      expect(hand2.beats_hand?(hand1)).to eq(false)
    end
  end

end

describe "player" do 

  subject(:player){Player.new("John", 200)}

  it "initializes with a name and a pot" do 
    expect(player.name).to eq("John")
    expect(player.pot).to eq(200)
  end 

  it "pot defaults to 100" do 
    player2 = Player.new("Jack")
    expect(player2.pot).to eq(100)
  end

  it "subtracts raise amount from pot" do 
    allow(player).to receive(:gets).and_return("100\n")
    player.get_raise_amount
    expect(player.pot).to eq(100)
  end

  it "returns appropriate string for get_option" do 
    allow(player).to receive(:gets).and_return("F\n")
    expect(player.get_option).to eq("f")
    allow(player).to receive(:gets).and_return("C\n")
    expect(player.get_option).to eq("c")
    allow(player).to receive(:gets).and_return("R\n")
    expect(player.get_option).to eq("r")
  end

end

describe "player and hand integration tests" do 

  let(:hand){Hand.new([Card.new(11, :spades), Card.new(10, :spades), Card.new(12, :spades), Card.new(13, :spades), Card.new(14, :spades)])} 
  let(:player){Player.new("John", 200)}

  it "returns the proper number of cards when discarding" do 
    player.hand = hand
    allow(player).to receive(:gets).and_return("1\n")
    allow(player).to receive(:gets).and_return("1\n")
    player.get_discards 
    expect(player.hand.length).to eq(4)
  end

  it "adds the correct number of cards" do 
    player.hand = hand
    player.add_cards([Card.new(15, :spades)]) 
    expect(player.hand.length).to eq(6)
  end

end


describe "game" do 
  let(:deck){Deck.new}
  let(:players){[Player.new("John"), Player.new("Jack")]}
  let(:john_double){double("John")}
  let(:jack_double){double("Jack")}
  let(:broke_double){double("John")}
  let(:john_hand_double){double("hand1")}
  let(:jack_hand_double){double("hand2")}
  subject(:game){Game.new(deck, players)}

  it "initializes with deck and players" do 
    game = Game.new(deck, players)
    expect(game.deck).to eq(deck)
    expect(game.players).to eq(players)
  end

  it "removes broke players" do 
    allow(broke_double).to receive(:pot).and_return(0)
    game = Game.new(deck, [broke_double])
    expect(game.players.length).to eq(1)
    game.remove_broke_players
    expect(game.players.length).to eq(0)
  end

  describe "determines winners correctly" do 
    it "determines winner when hand ranking is different" do 
      allow(john_hand_double).to receive(:ranking).and_return(2)
      allow(jack_hand_double).to receive(:ranking).and_return(3)
      allow(john_double).to receive(:hand).and_return(john_hand_double)
      allow(jack_double).to receive(:hand).and_return(jack_hand_double)
      game = Game.new(deck, [john_double, jack_double])
      expect(game.determine_winner([john_double, jack_double])).to eq(jack_double)
    end 

    it "determines winner by high card when hand ranking is the same" do 
      allow(john_hand_double).to receive(:ranking).and_return(2)
      allow(jack_hand_double).to receive(:ranking).and_return(2)
      allow(john_hand_double).to receive(:high_card_rank).and_return(2)
      allow(jack_hand_double).to receive(:high_card_rank).and_return(3)
      allow(john_double).to receive(:hand).and_return(john_hand_double)
      allow(jack_double).to receive(:hand).and_return(jack_hand_double)
      game = Game.new(deck, [john_double, jack_double])
      expect(game.determine_winner([john_double, jack_double])).to eq(jack_double)
    end

  end

  describe "handles loops correctly" do 
    it "handles a round with all checks" do 
      allow(john_double).to receive(:get_option).and_return("c")
      allow(john_double).to receive(:get_raise_amount).and_return(10)
      allow(john_double).to receive(:update_pot)
      allow(jack_double).to receive(:get_option).and_return("c")
      allow(jack_double).to receive(:update_pot)
      game = Game.new(deck, [john_double, jack_double])
      expect(game.get_bets([john_double, jack_double], 10)).to eq(20)
    end


    it "handles a round with 1 raise" do 
      allow(john_double).to receive(:get_option).exactly(2).times.and_return("r", "c")
      allow(john_double).to receive(:get_raise_amount).and_return(10)
      allow(john_double).to receive(:update_pot)
      allow(jack_double).to receive(:get_option).and_return("c")
      allow(jack_double).to receive(:update_pot)
      game = Game.new(deck, [john_double, jack_double])
      expect(game.get_bets([john_double, jack_double], 10)).to eq(40)
    end


    it "handles folding players" do 
      allow(john_double).to receive(:get_option).and_return("c")
      allow(john_double).to receive(:get_raise_amount).and_return(10)
      allow(john_double).to receive(:update_pot)
      allow(jack_double).to receive(:get_option).and_return("f")
      arr = [john_double, jack_double]
      game = Game.new(deck, arr)
      expect(game.get_bets([john_double, jack_double], 10)).to eq(10)
    end

  end


  describe "game and deck integration" do 

    it "removes the appropriate amount of cards when dealing" do 
      game.deal 
      expect(deck.cards.length).to eq(42)
    end

  end


end




















