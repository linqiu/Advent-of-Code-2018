require "./parsed_event"

class Guard
  @id : String
  @current_date : String
  @current_sleep : Int32

  # what @hash looks like
  {
    "dates" => {
      "2012-12-12" => 0,
    },
    "repeated_minutes" => {
      "01" => 1,
      "02" => 1,
    },
  }
  @result_hash : Hash(String, Hash(String, Int32))

  def initialize(event : NamedTuple(name: Action, event_data: String), time : Time)
    @id = event[:event_data]
    @current_date = time.to_s("%Y-%m-%d")
    @result_hash = {
      "dates" => {
        @current_date => 0,
      },
      "repeated_minutes" => {} of String => Int32,
    }
    @current_sleep = 0
  end

  def starts_shift(time)
    @current_date = time.to_s("%Y-%m-%d")
    if @result_hash["dates"][@current_date].empty?
      @result_hash["dates"][@current_date] = 0
    end
  end

  def sleep(time)
    @current_sleep = time.to_s("%M").to_i
  end

  def wakeup(time)
    wakeup = time.to_s("%M").to_i
    minutes = wakeup - @current_sleep
    @result_hash["dates"][@current_date] += minutes

    (@current_sleep...wakeup).to_a.each do |time|
      if @result_hash["repeated_minutes"][time.to_s]?
        @result_hash["repeated_minutes"][time.to_s] += 1
      else
        @result_hash["repeated_minutes"][time.to_s] = 1
      end
    end
  end

  def totals
    total_time = @result_hash["dates"].values.sort.reverse.first
    minutes_array = @result_hash["repeated_minutes"].to_a

    if minutes_array.empty?
      longest_minute = {"0", 0}
    else
      longest_minute = minutes_array.sort_by { |arr| arr[1] }.reverse.first
    end

    {total_time, longest_minute, @id}
  end

  def result_hash
    @result_hash
  end
end
