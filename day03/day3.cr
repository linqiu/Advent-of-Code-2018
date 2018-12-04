input = File.read_lines("./day3.txt")
# input = File.read_lines("./sample.txt")

part1Hash = input.reduce({} of Tuple(Int32, Int32) => Int32) do |acc, line|
  #1 @ 1,3: 4x4 -- sample line
  id, at, coords, nxn = line.split(" ")
  string_x, string_y = coords.rstrip(":").split(",")
  string_width, string_height = nxn.split("x")

  x = string_x.to_i
  y = string_y.to_i
  width = string_width.to_i
  height = string_height.to_i

  x_coords = (x...x+width).to_a
  y_coords = (y...y+height).to_a

  #
  x_coords.each do |x_coord|
    y_coords.each do |y_coord|
      tuple = { x_coord, y_coord }
      if acc[tuple]?
        acc[tuple] += 1
      else
        acc[tuple] = 1
      end
    end
  end

  acc
end

puts part1Hash.values.count{|num| num > 1}

# part 2 requires the hash type to be Tuple(Int32, Int32) => Array(String)

# making a new hash cause my wife wants me to sleep
cleanHash = {} of String => Bool
part2Hash = input.reduce({} of Tuple(Int32, Int32) => Array(String)) do |acc, line|
  #1 @ 1,3: 4x4 -- sample line
  id, at, coords, nxn = line.split(" ")
  string_x, string_y = coords.rstrip(":").split(",")
  string_width, string_height = nxn.split("x")

  x = string_x.to_i
  y = string_y.to_i
  width = string_width.to_i
  height = string_height.to_i

  x_coords = (x...x+width).to_a
  y_coords = (y...y+height).to_a
  cleanHash[id] = false

  #
  x_coords.each do |x_coord|
    y_coords.each do |y_coord|
      tuple = { x_coord, y_coord }
      if acc[tuple]?
        acc[tuple].push(id)
        acc[tuple].each{ |k| cleanHash[k] = true }
      else
        acc[tuple] = [id]
      end
    end
  end

  acc
end

puts cleanHash.reject {|key, value| value == true }
