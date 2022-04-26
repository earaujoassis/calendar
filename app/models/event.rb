class Event < ApplicationRecord
  validates :name, presence: true
  validates :day, presence: true, :inclusion => 1..31
  validates :month, presence: true, :inclusion => 1..12
  validates :year, presence: false, numericality: { greater_than_or_equal_to: 1900, allow_nil: true }

  validates_with DateValidator

  def self.all_for(year:, month:, day:)
    Event.where(year: year, month: month, day: day)
      .or(Event.where(year: nil, month: month, day: day))
      .order(year: :desc, name: :asc)
      .all
  end
end
