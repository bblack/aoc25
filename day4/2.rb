grid = []

def grid_at(grid, row, col)
  return nil if row < 0 || row >= grid.length
  return nil if col < 0 || col >= grid[0].length

  return grid[row][col]
end

def grids_equal(a, b)
  return false unless a.length == b.length

  a.length.times do |i|
    if a[i] != b[i]
      puts "row #{i} diff: #{a[i]} / #{b[i]}"
      return false
    end
  end
  return true
end

def neighbors(grid, row, col)
  return [
    grid_at(grid, row-1, col-1),
    grid_at(grid, row-1, col),
    grid_at(grid, row-1, col+1),
    grid_at(grid, row, col-1),
    # grid_at(grid, row, col), # that's me!
    grid_at(grid, row, col+1),
    grid_at(grid, row+1, col-1),
    grid_at(grid, row+1, col),
    grid_at(grid, row+1, col+1)
  ]
end

def deep_dup(grid)
  return grid.map { |row| row.dup }
end

def grid_to_s(grid)
  output_string = ''
  grid.each_with_index do |row, i|
    row.each_with_index do |_, j|
      c = grid_at(grid, i, j)
      if c == '@'
        if neighbors(grid, i, j).count { |n| n == '@' } < 4
          output_string += 'x'
        else
          output_string += '@'
        end
      else
        output_string += c
      end
    end

    output_string += "\r\n"
  end
  return output_string
end

###

filepath = ARGV[0]

puts "reading from #{filepath}"

File.open(filepath).each_line do |line|
  row = line.strip.split('')
  grid << row
end

history = []
removed_count = 0

loop do
  history << grid

  puts "#{history.length}.\n"
  puts grid_to_s(grid) + "\n"

  new_grid = deep_dup(grid)

  # find all accessible neighbors. for each, "remove" corresponding cell in new_grid
  grid.each_with_index do |row, i|
    row.each_with_index do |_, j|
      c = grid_at(grid, i, j)
      if c == '@'
        if neighbors(grid, i, j).count { |n| n == '@' } < 4
          new_grid[i][j] = '.' # remove!
          removed_count += 1
        end
      end
    end
  end

  if grids_equal(new_grid, grid)
    break
  else
    grid = new_grid
  end
end

puts "Done! Removed #{removed_count} rolls"
