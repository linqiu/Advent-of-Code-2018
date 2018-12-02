input = File.read_lines("./day1a.txt")

sum = input.reduce(0) { |acc, n| acc + n.to_i }

puts "part 1 answer: "
puts sum

# second part
# keep looping until we get a repeat
repeat = nil
hash = {} of Int32 => Int32
init = 0

while repeat.nil?
  init = input.reduce(init) do |acc, n|
    if hash[acc]?
      hash[acc] = hash[acc] + 1
      repeat ||= acc
    else
      hash[acc] = 1
    end
    acc + n.to_i
  end
end

puts repeat
