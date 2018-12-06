enum Action
  StartShift
  Sleep
  Wakeup
end

def parse_event(event : String) : NamedTuple(name: Action, event_data: String)
  is_shift = event.includes?("begins shift")

  if is_shift
    _, guard = event.split('#')
    return {name: Action::StartShift, event_data: guard.rstrip(" begins shift")}
  end

  if event.includes?("falls asleep")
    return {name: Action::Sleep, event_data: "sleep"}
  end

  {name: Action::Wakeup, event_data: "wakeup"}
end
