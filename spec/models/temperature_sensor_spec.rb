require 'rails_helper'
require 'dht_sensor' if Rails.env.test?

RSpec.describe TemperatureSensor do
  subject(:temperature_sensor) { TemperatureSensor.create(name: 'temp sensor 1') }

  fixtures :devices

  it 'has basic fields and is valid' do   #
    expect(temperature_sensor).to be_valid
    expect(temperature_sensor.name).to eql 'temp sensor 1'
    expect(temperature_sensor.configuration).to be_empty
  end

  describe "reading temperature" do
    let(:temp) { 19.12 }
    let(:humidity) { 53.32 }

    subject(:temperature_sensor) { devices(:bedroom_sensor) }

    before do
      allow(DhtSensor).to receive(:read)
                              .with(temperature_sensor.configuration['pin'].to_i,
                                    temperature_sensor.configuration['driver'].to_i)
                              .and_return(double(temp: 19.12, humidity: 53.32))
    end

    it 'reads the temperature from `DhtSensor`' do
      expect(temperature_sensor.read).to match hash_including(temperature: temp, humidity: humidity)
    end
  end
end