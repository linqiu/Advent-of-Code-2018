require "./parsed_line"
require "./parsed_event"
require "./guard"

input = File.read_lines("./day04.txt")
# input = File.read_lines("./sample.txt")

time1 = Time.now
current_guard = ""
part1Hash = input.reduce({} of String => Guard) do |acc, line|
  parsed = ParsedLine.new(line)

  event = parse_event(parsed.event)

  case event[:name]
  when Action::StartShift
    if !acc[event[:event_data]]?
      acc[event[:event_data]] = Guard.new(event, parsed.time)
    end

    current_guard = event[:event_data]
  when Action::Sleep
    acc[current_guard].sleep(parsed.time)
  when Action::Wakeup
    acc[current_guard].wakeup(parsed.time)
  end

  acc
end

# alias totals = Tuple(Int32, Tuple(String, Int32), String)
time2 = Time.now
# use total minutes sleeping as sort order
shittiest_guard = (part1Hash.values.map &.totals).sort { |a, b| -(a[0] <=> b[0]) }.first
puts shittiest_guard
puts shittiest_guard[2].to_i * shittiest_guard[1][0].to_i
puts "completed 1 in #{time2 - time1}"

time1 = Time.now
# use most often minute slept as sort order
shittiest_guard = (part1Hash.values.map &.totals).sort { |a, b| -(a[1][1] <=> b[1][1]) }.first
time2 = Time.now
puts shittiest_guard
puts shittiest_guard[1][0].to_i * shittiest_guard[2].to_i
puts "completed 2 in #{time2 - time1}"
