require 'set'

filepath = ARGV[0]

puts "reading from #{filepath}"

beam_positions = Set.new
split_count = 0

File.open(filepath).each_line do |line|
  line = line.rstrip

  line.split('').each_with_index do |c, i|
    if c == 'S'
      beam_positions << i
    end

    if c == '^'
      if beam_positions.include?(i)
        beam_positions.delete(i)
        beam_positions.add(i-1) if i-1 >= 0
        beam_positions.add(i+1) if i+1 < line.length
        split_count += 1
      end
    end
  end

  line.length.times do |i|
    print beam_positions.include?(i) ? '|' : line[i]
  end

  print "\n"
end

puts "split_count: #{split_count}"
