filepath = ARGV[0]

puts "reading from #{filepath}"

fresh_ranges = []

File.open(filepath).each_line do |line|
  line = line.strip
  range = line.strip.split("-").map(&:to_i)
  range = range[0]..range[1]

  fresh_ranges << range
end

fresh_ranges.sort_by! { |r| [r.min, r.max] }

puts "sorted:"
puts fresh_ranges

fresh_ranges.length.times do |i|
  range = fresh_ranges[i]
  ((i+1)..(fresh_ranges.length-1)).each do |j|
    later_range = fresh_ranges[j]

    break if later_range.begin > range.end
    fresh_ranges[j] = (range.end + 1)..(later_range.end)
  end
end

puts "coalesced:"
puts fresh_ranges

puts "\nsum: #{fresh_ranges.sum(&:size)}"
