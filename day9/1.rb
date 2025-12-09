filepath = ARGV[0]

puts "reading from #{filepath}"

points = []
best_pair = nil

def area(p, q)
  dx = (p[0]-q[0]).abs + 1
  dy = (p[1]-q[1]).abs + 1
  (dx*dy)
    #.tap { |x| puts "area(#{p}, #{q}) = #{dx}*#{dy} = #{x}" }
end

File.open(filepath).each_line do |line|
  p = line.rstrip.split(",").map(&:to_i)
  puts p.inspect
  points << p
end

diags = Enumerator::Product.new(points, points).to_a
best = diags.max do |a, b| 
  area(a[0], a[1]) <=> area(b[0], b[1]) 
end

puts "best pair: #{best} = #{area(best[0], best[1])}"
