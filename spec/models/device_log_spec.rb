require 'rails_helper'

RSpec.describe DeviceLog do
  fixtures :devices

  let(:device) { devices(:bedroom_sensor) }
  subject(:device_log) { DeviceLog.create(device: device, data: { type: DeviceLog::TEMPERATURE_TYPE, temperature: 12.34, humidity: 45.67 }) }

  it 'belongs to a device' do
    expect(device_log.device).to eq device
  end

  it 'it has the log data' do   #
    expect(device_log.data['type']).to eq DeviceLog::TEMPERATURE_TYPE
    expect(device_log.data['temperature']).to eq 12.34
    expect(device_log.data['humidity']).to eq 45.67
  end

  it 'is found through the device' do
    expect(device.device_logs).to include device_log
  end
end