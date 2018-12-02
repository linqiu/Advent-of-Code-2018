input = File.read_lines("./day02.txt")

sum = input.reduce({2 => 0, 3 => 0}) do |acc, line|
  hash = {} of Char => Int32
  line.each_char do |c|
    if hash[c]?
      hash[c] = hash[c] + 1
    else
      hash[c] = 1
    end
  end

  values = hash.values
  if values.includes?(2)
    acc[2] = acc[2] + 1
  end
  if values.includes?(3)
    acc[3] = acc[3] + 1
  end

  acc
end

puts "part 1 answer: "
puts sum[2] * sum[3]

# i don't want to implement levenshtein distance
# so i'll just compare arrays for more than one error
# still two nested loops either way
# i could keep track of an mutating array that reduces
# in size as I iterate through...

input.each do |line|
  match = input.find do |line2|
    false if line === line2
    wrongs = 0
    line.each_char_with_index do |c, i|
      if c != line2[i]
        wrongs += 1
      end
    end

    wrongs === 1
  end

  puts line if match
  puts match if match
end
