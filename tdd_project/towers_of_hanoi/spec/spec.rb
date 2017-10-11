require_relative '../hanoi'

describe "towers of hanoi" do 

  subject(:game){Hanoi.new}

  describe "towers" do 
    it 'initializes towers as an array of arrays' do 
      expect(game.towers[0]).to be_instance_of(Array)
    end

    it 'uses proper starting position' do 
      expect(game.towers).to eq([[3,2,1], [], []])
    end

  end 

  describe "move_disk" do 
    it 'moves disk to specified tower' do 
      game.move_disk(0,1) 
      expect(game.towers).to eq([[3,2], [1], []])
    end

    it 'doesn\'t move a bigger disk on top of a smaller disk' do 
      game.move_disk(0,1)
      game.move_disk(0,1)
      expect(game.towers).to eq([[3,2], [1], []])
    end
  end

  describe "won?" do 
    it 'returns false when the game isn\'t won' do 
      expect(game.won?).to eq(false)
    end

    it 'returns true when the game is won' do 
      game.move_disk(0,1)
      game.move_disk(0,2)
      game.move_disk(1,2)
      game.move_disk(0,1)
      game.move_disk(2,0)
      game.move_disk(2,1)
      game.move_disk(0,1)
      expect(game.won?).to eq(true)
    end
  end

  describe "render" do 
    it 'renders correctly' do 
      expect(game.render).to eq("Tower1: [3, 2, 1]\nTower2: []\nTower3: []")
    end
  end



end