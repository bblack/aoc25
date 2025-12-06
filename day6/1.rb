filepath = ARGV[0]

puts "reading from #{filepath}"

problems = []
grand_total = 0

File.open(filepath).each_line do |line|
  line = line.strip

  puts "line: #{line}"

  tokens = line.split(/\s+/)

  if tokens.all? { |t| t =~ /^\d+$/ }
    tokens.each_with_index do |s, i|
      problems[i] ||= []
      problems[i] << s.to_i
      puts "problems: #{problems}"
    end
  else
    # assume it's all operators
    tokens.each_with_index do |s, i|
      total = problems[i].reduce(s.to_sym)
      puts "problem #{i+1} total: #{total}"
      grand_total += total
    end
    break
  end
end

puts "grand_total: #{grand_total}"
