class EventsController < ApplicationController
  before_action :validate_event, only: :create

  def create
    event = Event.create(event_params)

    render json: { id: event.id }
  end

  private

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
