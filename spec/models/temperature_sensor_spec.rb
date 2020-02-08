require 'rails_helper'

RSpec.describe TemperatureSensor do
  subject(:temperature_sensor) { TemperatureSensor.create(name: 'temp sensor 1') }

  fixtures :devices

  it 'has basic fields and is valid' do   #
    expect(temperature_sensor).to be_valid
    expect(temperature_sensor.name).to eql 'temp sensor 1'
    expect(temperature_sensor.configuration).to be_empty
  end

  describe "reading temperature"
end