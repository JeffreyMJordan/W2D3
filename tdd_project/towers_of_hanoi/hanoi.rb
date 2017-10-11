class Hanoi 

  attr_reader :towers
    
  def initialize
    @towers = [[3,2,1], [], []]
  end

  def move_disk(start_tower, end_tower)
    if start_tower<0 or start_tower>2 or end_tower<0 or end_tower>2 
      puts "Please choose existing towers" 
      return 
    end
    disk = @towers[start_tower].pop 
    if valid_move?(disk, end_tower) 
      @towers[end_tower] << disk 
    else 
      puts "That isn't a valid move"
      @towers[start_tower] << disk 
    end
  end

  def valid_move?(disk, end_tower)
    return true if @towers[end_tower].empty?
    return false if @towers[end_tower].last < disk 
    true 
  end

  def won?
    @towers.each_with_index do |tower, idx| 
      return true if tower==[3,2,1] and idx!=0
    end
    false 
  end

  def render
    str = ""
    str += "Tower1: #{@towers[0]}\n"
    str += "Tower2: #{@towers[1]}\n"
    str +=  "Tower3: #{@towers[2]}"
    puts str 
    str 
  end

  def game_loop 
    intro_text 
    until won? 
      render 
      input = get_input
      move_disk(input[0], input[1])

    end
    winning_text 
  end

  def get_input 
    puts "Input the tower you want to move from: "
    start = gets.chomp.to_i
    puts "Input the tower you want to move to: "
    en = gets.chomp.to_i
    [start, en]
  end

  def winning_text 
    puts "Congrats! You won!"
  end

  def intro_text 
    puts "Welcome to Towers of Hanoi"
  end


end

if __FILE__==$0 
  game = Hanoi.new 
  game.game_loop
end