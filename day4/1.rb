grid = []

def grid_at(grid, row, col)
  return nil if row < 0 || row >= grid.length
  return nil if col < 0 || col >= grid[0].length

  return grid[row][col]
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

###

filepath = ARGV[0]

puts "reading from #{filepath}"

File.open(filepath).each_line do |line|
  row = line.strip.split('')
  grid << row
end

accessible_count = 0
output_string = ''

grid.each_with_index do |row, i|
  row.each_with_index do |_, j|
    c = grid_at(grid, i, j)
    if c == '@'
      if neighbors(grid, i, j).count { |n| n == '@' } < 4
        accessible_count += 1
        #puts "incremented accessible_count: #{accessible_count}"
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

puts "\n" + output_string + "\n"
puts "accessible_count: #{accessible_count}"
