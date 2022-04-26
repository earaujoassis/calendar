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

  test "#all_for" do
    Event.create(name: "New Year's Day", day: 1, month: 1)
    Event.create(name: 'Halloween', day: 31, month: 10)
    Event.create(name: 'Christmas', day: 25, month: 12)
    Event.create(name: 'Annual Meeting', day: 10, month: 4)
    Event.create(name: 'This Year Meeting', day: 10, month: 4, year: 2022)

    events = Event.all_for(year: 2022, month: 4, day: 10)
    assert_equal 2, events.length
    assert_equal 'Annual Meeting', events.first.name
    assert_equal 'This Year Meeting', events.last.name
  end
end
