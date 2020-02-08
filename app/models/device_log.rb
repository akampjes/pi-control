class DeviceLog < ApplicationRecord
  TEMPERATURE_TYPE = 'temperature'
  LOG_TYPES = [TEMPERATURE_TYPE]

  belongs_to :device
end