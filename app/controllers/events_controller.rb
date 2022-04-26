class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :validate_event, only: :create
  before_action :validate_query, only: :index

  def index
    events = Event.all_for(day: @day, month: @month, year: @year)

    render json: {
      total_events: events.length,
      events: events.map { |e| { name: e.name } },
    }
  end

  def create
    event = Event.create(event_params)

    render json: { id: event.id }
  end

  private

  def validate_query
    @day = params[:day].to_i
    @month = params[:month].to_i
    @year = params[:year].to_i

    validator_valid = @day.present? &&
      @month.present? &&
      @year.present?

    return if validator_valid && Date.valid_date?(@year, @month, @day)

    render json: { errors: "invalid query; please provide valid day, month, and year" }, status: 400
  end

  def event_params
    params.require(:event).permit(:name, :day, :month, :year)
  end

  def validate_event
    validator_valid = params[:event].present? &&
      params[:event][:name].present? &&
      params[:event][:day].present? &&
      params[:event][:month].present?

    return if validator_valid

    render json: { errors: "invalid event" }, status: 422
  end
end
