require 'rails_helper'

RSpec.describe LogTemperature do
  fixtures :devices

  let(:sensor) { devices(:bedroom_sensor) }
  subject(:log_temperature) { LogTemperature.new(sensor: sensor) }

  it 'creates a new temperature log' do
    expect { log_temperature.call }.to change { DeviceLog.count }.by 1
  end

  it 'logs temperature and humidity' do
    log_temperature.call

    log = DeviceLog.last

    expect(log.data['type']).to eq DeviceLog::TEMPERATURE_TYPE
    expect(log.data['temperature']).to eq DhtSensor::DUMMY_TEMP
    expect(log.data['humidity']).to eq DhtSensor::DUMMY_HUMIDITY
  end
end
