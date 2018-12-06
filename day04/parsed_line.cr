class ParsedLine
  @timestamp : String
  @event : String

  def initialize(line : String)
    @timestamp, @event = line.split("]")
  end

  def time : Time
    Time.parse(@timestamp.lstrip("["), "%Y-%m-%d %H:%M", Time.now.location)
  end

  def event
    @event
  end
end
