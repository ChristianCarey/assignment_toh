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
    from = @columns[from_column.to_i - 1]
    to = @columns[to_column.to_i - 1]
    disk_size = 0
    from_cell_index = 0
    to_cell_index = 2

    from.each_with_index do |cell, cell_index|
      if cell != 0
        disk_size = cell
        from_cell_index = cell_index
        from[cell_index] = 0
        break
      end
    end

    to.reverse_each do |cell|
      if cell!= 0 && cell < disk_size
        puts "ILLEGAL MOVE: No disk may be placed on top of a smaller disk."
        from[from_cell_index] = disk_size
        break
      elsif cell == 0
        to[to_cell_index] = disk_size
        break
      end
      to_cell_index -= 1
    end
  end

  def check_quit(input)
    if input == 'q'
      puts "Try again later!"
      exit
    end
  end

  def check_victory
    @columns.each_with_index do |column, index|
      if index != 0 && column == [1,2,3]
        @game_over = true
      end
    end
  end

  def play
    puts "Move these three disks to another column. Follow these three rules:"
    puts "\t1. Only one disk can be moved at a time."
    puts "\t2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack."
    puts "\t3. No disk may be placed on top of a smaller disk."
    puts "BEGIN:"
    render

    until @game_over
      puts "Move from which column?"
      from_column = gets.chomp
      check_quit(from_column)

      puts "Move to which column?"
      to_column = gets.chomp
      check_quit(to_column)

      move_disk(from_column, to_column)
      render
      check_victory
    end

    puts "Game over!"
  end
end

game = TowerOfHanoi.new
game.play



