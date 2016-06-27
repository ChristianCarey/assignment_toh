require 'pry'

class TowerOfHanoi
  attr_accessor :rows, :game_over

  def initialize
    @columns = [ [1,2,3], [0,0,0] , [0,0,0] ]
    @game_over = false
  end

  def columns_to_rows
    rows = [ [0,0,0], [0,0,0], [0,0,0] ]
    
    @columns.each_with_index do |column, x_coordinate|
      column.each_with_index do |cell, y_coordinate|
        if cell == 0
          next
        else
          rows[y_coordinate][x_coordinate] = cell
        end
      end
    end

    rows
  end

  def render
    rows = columns_to_rows
    rows.each do |row|
      print '|'
      row.each do |cell|
        extra_space = " " * (10 - cell)
        print '*' * cell
        print "#{extra_space}|"
      end
      puts ''
    end
  end

  def move_disk(from_column, to_column)
    from = @columns[from_column - 1]
    to = @columns[to_column - 1]
    disk_size = 0
    to_cell_index = 2

    from.each_with_index do |cell, cell_index|
      if cell != 0
        disk_size = cell
        from[cell_index] = 0
        break
      end
    end

    to.reverse_each do |cell|
      if cell == 0
        to[to_cell_index] = disk_size
        break
      end
      to_cell_index -= 1
    end
  end

  def play
    puts "Move these three disks to another column. Follow these three rules:"
    puts "\t1. Only one disk can be moved at a time."
    puts "\t2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack."
    puts "\t3. No disk pay be placed on top of a smaller disk."
    puts "BEGIN:"
    render

    until @game_over
      puts "Move from which column?"
      from_column = gets.chomp.to_i
      puts "Move to which column?"
      to_column = gets.chomp.to_i
      move_disk(from_column, to_column)
      render
    end
  end
end

game = TowerOfHanoi.new
game.play



