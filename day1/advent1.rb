filename = ARGV[0]

puts "reading from #{filename}"

lines = File.readlines(filename)

pos = 50
history = [pos]

lines.each do |line|
  match = /^([LR])(\d*)$/.match(line.rstrip)

  d = case match[1]
  when "L"
    -Integer(match[2])
  when "R"
    Integer(match[2])
  else
    raise "Bad input line: " + line
  end

  pos = (pos + d) % 100
  history << pos
end

puts "lines: #{lines.count}"
puts "final pos: #{pos}"
puts "hist count: #{history.count}"
puts "num zeroes: #{history.count { |x| x == 0 }}"
