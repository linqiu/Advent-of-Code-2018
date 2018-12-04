input = File.read_lines("./day3.txt")
# input = File.read_lines("./sample.txt")

class ParsedLine
  @id : String
  @x : Int32
  @y : Int32
  @width : Int32
  @height : Int32

  def initialize(line : String)
    @id, at, coords, nxn = line.split(" ")
    @x, @y = coords.rstrip(":").split(",").map &.to_i
    @width, @height = nxn.split("x").map &.to_i
  end

  def id : String
    @id
  end

  def x_range : Array(Int32)
    (@x...@x+@width).to_a
  end

  def y_range : Array(Int32)
    (@y...@y+@height).to_a
  end
end

time1 = Time.now
part1Hash = input.reduce({} of Tuple(Int32, Int32) => Int32) do |acc, line|
  parsed = ParsedLine.new(line)

  # spread the range
  x_range = parsed.x_range
  y_range = parsed.y_range

  # map the coordinates
  x_range.each do |x|
    y_range.each do |y|
      tuple = { x, y }
      if acc[tuple]?
        acc[tuple] += 1
      else
        acc[tuple] = 1
      end
    end
  end

  acc
end

time2 = Time.now
puts part1Hash.values.count{|num| num > 1}
puts "completed 1 in #{time2-time1}"

# part 2 requires the hash type to be Tuple(Int32, Int32) => Array(String)
# making a new hash cause my wife wants me to sleep
cleanHash = {} of String => Bool
time1 = Time.now
part2Hash = input.reduce({} of Tuple(Int32, Int32) => Array(String)) do |acc, line|
  parsed = ParsedLine.new(line)

  # spread the range
  x_range = parsed.x_range
  y_range = parsed.y_range
  id = parsed.id
  cleanHash[id] = false

  #
  x_range.each do |x|
    y_range.each do |y|
      tuple = { x, y }
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

time2 = Time.now
puts cleanHash.reject {|key, value| value == true }
puts "completed 1 in #{time2-time1}"
