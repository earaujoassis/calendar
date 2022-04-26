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
end
