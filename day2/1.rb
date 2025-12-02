filepath = ARGV[0]
puts "reading from #{filepath}"
input = File.read(filepath)
ranges = input.split(",")

invalids = []

ranges.each do |range|
  lower, upper = range.split("-")
  lower = Integer(lower)
  upper = Integer(upper)
  (lower..upper).each do |n|
    s = n.to_s
    next unless s.length.even?
    first_half = s[0..s.length/2-1]
    second_half = s[s.length/2..s.length-1]
    if first_half == second_half
      invalids << n
    end
  end
end

puts "invalids: #{invalids}"
puts "sum of invalids: #{invalids.sum}"
