filepath = ARGV[0]

puts "reading from #{filepath}"

section = :fresh_ingreds
fresh_ranges = []
avail_ingreds = []

File.open(filepath).each_line do |line|
  line = line.strip
  puts "read line: #{line}"

  case section
  when :fresh_ingreds
    if line.empty?
      puts "remainder of file is avail_ingreds"
      section = :avail_ingreds
      next
    end

    range = line.strip.split("-").map(&:to_i)
    range = range[0]..range[1]
    fresh_ranges << range
    puts "added range #{range}"
  when :avail_ingreds
    id = line.strip.to_i
    is_fresh = fresh_ranges.any? { |range| range.cover?(id) }
    avail_ingreds << {id: line.strip, is_fresh: is_fresh }
  else
    puts "unknown section #{section}"
  end
end

puts "ingred count: #{avail_ingreds.count}"
puts "  fresh: #{avail_ingreds.count { |x| x[:is_fresh] }}"
