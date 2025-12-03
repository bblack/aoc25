filepath = ARGV[0]

puts "reading from #{filepath}"

sum = 0

File.open(filepath).each_line do |line|
  joltage = 0
  digits = line.strip.split('').map { |c| Integer(c) }
  digits.each_with_index do |a, a_i|
    digits[(a_i+1)..].each do |b|
      candidate = a*10 + b
      joltage = candidate if candidate > joltage
    end
  end
  puts "joltage of line #{line} is #{joltage}"
  sum += joltage
end


puts "joltage of all banks: #{sum}"
