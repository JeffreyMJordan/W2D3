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
end