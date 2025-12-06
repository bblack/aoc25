filepath = ARGV[0]

puts "reading from #{filepath}"

big_matrix = []
problems = []
grand_total = 0

File.open(filepath).each_line do |line|
  line = line.chomp

  puts "line: #{line}"

  if line =~ /^[\d ]+$/
    big_matrix << line.split('')
  else
    # assume it's all operators
    operators = line.split(/\s+/)
    #puts "operators: #{operators}"
    #puts "big_matrix: #{big_matrix}"
    #puts "#{big_matrix.map(&:length)}"
    operands = big_matrix.transpose
      .map { |row| row.join('').strip }
      .map { |s| s.empty? ? nil : s.to_i }
    current_op = []

    while !operands.empty? || !operators.empty?
      
      #puts "operands: #{operands}"
      #puts "operators: #{operators}"
      operand = operands.shift #takes first
      if operand.nil?
        operator = operators.shift
        #puts "operator: #{operator}"
        total = current_op.reduce(operator)
        #puts "problem total: #{total}"
        grand_total += total
        current_op = []
        next
      end
      current_op << operand
    end
  end
end

puts "grand_total: #{grand_total}"
