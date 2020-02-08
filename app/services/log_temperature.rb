class LogTemperature
  def initialize(sensor:)
    @sensor = sensor
  end

  def call
    reading = @sensor.read

    DeviceLog.create!(device: @sensor,
                      data: {
                          type: DeviceLog::TEMPERATURE_TYPE,
                          temperature: reading[:temperature],
                          humidity: reading[:humidity]
                      })
  end
end