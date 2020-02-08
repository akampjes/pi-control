class LogTemperatureJob < ApplicationJob
  queue_as :default

  def perform(device_id)
    sensor = TemperatureSensor.find(device_id)

    LogTemperature.new(sensor: sensor).call
  end
end
