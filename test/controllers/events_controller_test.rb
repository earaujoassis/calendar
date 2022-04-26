require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should check for valid params on :create" do
    post '/events'
    assert_response 422
  end

  test "should create recurring event entry" do
    post '/events',
      params: { event: { name: 'Christmas', day: 25, month: 12 } }, as: :json
    assert_response :success
    response_body = JSON.parse(response.body, symbolize_names: true)
    event = Event.last
    assert_equal event.name, 'Christmas'
    assert_equal event.id, response_body[:id]
  end

  test "should create single event entry" do
    post '/events',
      params: { event: { name: 'Meeting', day: 10, month: 4, year: 2022 } }, as: :json
    assert_response :success
    response_body = JSON.parse(response.body, symbolize_names: true)
    event = Event.last
    assert_equal event.name, 'Meeting'
    assert_equal event.id, response_body[:id]
  end

  test "should check for valid params on :index" do
    get '/events'
    assert_response 400
  end

  test "should get all entries for a given date" do
    Event.create(name: "New Year's Day", day: 1, month: 1)
    Event.create(name: 'Halloween', day: 31, month: 10)
    Event.create(name: 'Christmas', day: 25, month: 12)
    Event.create(name: 'Annual Meeting', day: 10, month: 4)
    Event.create(name: 'This Year Meeting', day: 10, month: 4, year: 2022)

    expected_response = {
      "total_events" => 2,
      "events" => [
        {
          "name" => "Annual Meeting"
        },
        {
          "name" => "This Year Meeting"
        }
      ]
    }

    get '/events', params: { day: 10, month: 4, year: 2022 }
    assert_response :success
    assert_equal expected_response, JSON.parse(response.body)
  end
end
