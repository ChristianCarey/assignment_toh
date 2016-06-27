require 'byebug'

class TowerOfHanoi
  attr_accessor :rows, :game_over, :disks, :columns, :victory_column

  def initialize(disks=3)
    @disks = disks
    @columns = []
    @game_over = false
    @rows = []
  end

  def setup
    full_column = []
    empty_column = []
    rows = []

    @disks.times do |disk_size|
      full_column << disk_size + 1
    end

    @disks.times do |disk_size|
      empty_column << 0
    end

    @columns[0] = full_column
    @columns[1] = empty_column
    @columns[2] = empty_column.dup
    @victory_column = full_column

    @disks.times do
      rows << [0,0,0]
    end

    @rows = rows
  end

  def columns_to_rows
    @columns.each_with_index do |column, x_coordinate|
      column.each_with_index do |cell, y_coordinate|
        @rows[y_coordinate][x_coordinate] = cell
      end
    end

    rows
  end

  def render
    rows = columns_to_rows
    rows.each do |row|
      print '|'
      row.each do |cell|
        extra_space = " " * (@disks - cell)
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
    to_cell_index = @disks - 1

    from.each_with_index do |cell, cell_index|
      if cell != 0
        disk_size = cell
        from_cell_index = cell_index
        puts from[cell_index]
        from[cell_index] = 0
        puts from[cell_index]
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
      if index != 0 && column == @victory_column
        @game_over = true
      end
    end
  end

  def play
    setup
    puts "Move these three disks to another column. Follow these three rules:"
    puts "\t1. Only one disk can be moved at a time."
    puts "\t2. Each move consists of taking the upper disk from one of the stacks and placing it on top of another stack."
    puts "\t3. No disk may be placed on top of a smaller disk."
    puts "BEGIN:"
    render

    until @game_over
      puts "Move from which column? (type 'q' to quit)"
      from_column = gets.chomp
      check_quit(from_column)

      puts "Move to which column? (type 'q' to quit)"
      to_column = gets.chomp
      check_quit(to_column)

      move_disk(from_column, to_column)
      render
      check_victory
    end

    puts "Game over!"
  end
end

game = TowerOfHanoi.new(3)

game.play





