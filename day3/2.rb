filepath = ARGV[0]

puts "reading from #{filepath}"

sum = 0

# ideas:
# - 12 nested loops
# - largest digit, recurse
# - left to right [array of 12 indexes, monotone increasing] - way too slow. a single digit in outer level takes at least a minute.

def joltage(line, count, log=true)
  return [] if line.empty?
  return [] if count.zero?

  best_so_far = []
  digits = line.strip.split('').map { |c| Integer(c) }
  digits.each_with_index do |d, i|
    puts "working digit #{i}" if log
    candidate = [d]
    remaining_best_sequence = joltage(line[i+1..], count-1, false)
    candidate += remaining_best_sequence

    if digits_to_i(candidate) > digits_to_i(best_so_far)
      best_so_far = candidate
    end
  end
  best_so_far
end

def digits_to_i(a)
  a.map(&:to_s).join.to_i
end

File.open(filepath).each_line do |line|
  j = joltage(line, 12)
  puts "joltage of line #{line} is #{j}"
  sum += digits_to_i(j)
end

puts "joltage of all banks: #{sum}"
