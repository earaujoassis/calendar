require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "valid recurring event" do
    event = Event.new(name: 'Christmas', day: 25, month: 12)
    assert event.valid?
  end

  test "valid single event" do
    event = Event.new(name: 'Meeting', day: 10, month: 4, year: 2022)
    assert event.valid?
  end

  test "invalid date" do
    event = Event.new(name: 'Invalid', day: 31, month: 2)
    refute event.valid?

    event = Event.new(name: 'Invalid', day: 31, month: 2, year: 2022)
    refute event.valid?

    event = Event.new(name: 'Invalid', day: 10, month: 4, year: 1889)
    refute event.valid?
  end

  test "invalid event" do
    event = Event.new
    refute event.valid?
  end
end
