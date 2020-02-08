class TemperatureSensor < Device
  def read
    pin = configuration['pin'].to_i
    driver = configuration['driver'].to_i

    if Rails.env.development? || Rails.env.test?
      require 'dht_sensor' # Dummy from /lib
    end

    reading = DhtSensor.read(pin, driver)

    {
        temperature: reading.temp,
        humidity: reading.humidity
    }
  end
end