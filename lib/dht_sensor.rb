# Dummy class for in development and test because we can't complie DhtSensor unless
# we're running on a RPi
#
class DhtSensor
  DUMMY_TEMP = 22.12
  DUMMY_HUMIDITY = 43.75

  def self.read(pin, driver)
    OpenStruct.new(temp: DUMMY_TEMP, humidity: DUMMY_HUMIDITY)
  end
end