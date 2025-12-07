require 'set'

filepath = ARGV[0]

puts "reading from #{filepath}"

beam_positions = Set.new

File.open(filepath).each_line.with_index do |line, line_num|
  line = line.rstrip

  next_positions = []

  line.split('').each_with_index do |c, i|
    if c == 'S'
      next_positions << {pos: i, paths: 1}
    end
  end

  beam_positions.each do |b|
    if line[b[:pos]] == '^'
      next_positions << {pos: b[:pos]-1, paths: b[:paths]}
      next_positions << {pos: b[:pos]+1, paths: b[:paths]}
    else
      next_positions << {pos: b[:pos], paths: b[:paths]}
    end
  end

  beam_positions = next_positions
    .reduce({}) do |memo, obj|
      memo[obj[:pos]] = (memo[obj[:pos]] || 0) + obj[:paths]
      memo
    end
    .map do |pos, paths|
      {pos: pos, paths: paths}
    end
    .to_set

  puts "#{line_num}. #{beam_positions}"
  puts "paths: #{beam_positions.sum { |b| b[:paths] }}"
end
