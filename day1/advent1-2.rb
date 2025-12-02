filename = ARGV[0]

puts "reading from #{filename}"

lines = File.readlines(filename)

pos = 50
history = [pos]

lines.each do |line|
  match = /^([LR])(\d*)$/.match(line.rstrip)

  d = Integer(match[2])

  step = case match[1]
  when "L" then -1
  when "R" then 1
  else raise "Bad input line: " + line
  end

  d.times do
    pos = (pos + step) % 100
    history << pos
  end
end

puts "lines: #{lines.count}"
puts "final pos: #{pos}"
puts "hist count: #{history.count}"
puts "num zeroes: #{history.count { |x| x == 0 }}"
