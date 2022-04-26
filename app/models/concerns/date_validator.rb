class DateValidator < ActiveModel::Validator
  def validate(record)
    unless Date.valid_date?(record.year || 1900, record.month, record.day)
      record.errors.add(:day, "invalid date")
    end
  end
end
