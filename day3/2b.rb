def joltage(line, count, count_inv=0, log=true)
  line = line.strip

  log "#{'  '*count_inv}joltage(#{line}, #{count})..."

  if line.empty? || count.zero?
    log "#{'  '*(count_inv+1)}return 0"
    return 0
  end

  digits = line.split('')
    .map.with_index { |c, i| {value: Integer(c), pos: i} }

  # best one has 1) at least n-1 digits to the right, and
  # 2) among those, the highest (or tied for highest) first digit, and
  # 3) among those, the highest joltage among any n-1 length subsequence to its right
  candidates = digits.filter { |digit| digit[:pos] + count <= digits.length }
  biggest_candidate_value = candidates.map { |c| c[:value] }.uniq.max
  candidates = candidates.filter do |digit|
    digit[:value] == biggest_candidate_value
  end
  log "#{'  '*(count_inv+1)}candidates:"

  candidates.each { |c| log "#{'  '*(count_inv+1)}#{c}" }
  candidates = candidates.map do |digit|
    digit.merge(
      right_joltage: joltage(
        line[digit[:pos]+1..],
        count-1,
         count_inv + 1,
         false
      )
    )
  end

  log "#{'  '*(count_inv+1)}candidates: #{candidates}"
  best_candidate = candidates.max_by { |cand| cand[:right_joltage] }
  log "#{'  '*(count_inv+1)}best candidate: #{best_candidate}"

  out = 10**(count-1)*biggest_candidate_value + best_candidate[:right_joltage]
  log "#{'  '*(count_inv+1)}returning #{out}"

  return out
end

def digits_to_i(a)
  a.map(&:to_s).join.to_i
end

def log(s)
  #puts s
end

###

filepath = ARGV[0]

log "reading from #{filepath}"

sum = 0

File.open(filepath).each_line.with_index do |line, linenum|
  j = joltage(line, 12)
  puts "joltage of line #{linenum}: #{line} is #{j}"
  sum += j
end

puts "joltage of all banks: #{sum}"
