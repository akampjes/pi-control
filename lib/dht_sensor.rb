# Dummy class for in development and test because we can't complie DhtSensor unless
# we're running on a RPi
#
class DhtSensor
  def self.read(pin, driver)
    OpenStruct(temp: 22.12, humidity: 43.75)
  end
end