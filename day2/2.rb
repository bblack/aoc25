def invalid?(s)
  factors = factorize(s.length)
    .reject { |f| f == s.length }

  return factors.any? do |divisor|
    pieces = chunk(s, divisor)
    pieces.all? { |p| p == pieces[0] }
  end
end

def factorize(n)
  n.times.map { |m| m + 1 }
    .filter { |m| n % m == 0 }
end

def chunk(s, size)
  chunks = []
  i = 0
  while i < s.length do
    chunks << s[i...(i+size)]
    i += size
  end
  return chunks
end

###

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

    if invalid?(s)
      invalids << n
    end
  end
end

puts "invalids: #{invalids}"
puts "sum of invalids: #{invalids.sum}"
