require 'pry'

class TowerOfHanoi
  attr_accessor :rows
  @rows = [ [1,0,0], [2,0,0] , [3,0,0] ]

  def render
    @rows.each do |row|
      row.each do |cell|
        puts '*' * cell
      end
    end
  end

  def play
    puts "Move these three disks to another column. Follow these three rules:"
    puts "\t1. Only one disk can be moved at a time."
    puts "\t2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack."
    puts "\t3. No disk pay be placed on top of a smaller disk."
    puts "BEGIN:"
    self.render
  end
end

game = TowerOfHanoi.new

game.play







