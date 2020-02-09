class DeviceLog < ApplicationRecord
  TEMPERATURE_TYPE = 'temperature'
  LOG_TYPES = [TEMPERATURE_TYPE]

  belongs_to :device

  scope :most_recent_first, -> { order(created_at: :desc) }
end