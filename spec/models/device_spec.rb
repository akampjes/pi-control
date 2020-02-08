require 'rails_helper'

RSpec.describe Device do
  subject(:device) { Device.create(name: 'device name') }

  it 'has basic fields and is valid' do   #
    expect(device).to be_valid
    expect(device.name).to eql 'device name'
    expect(device.configuration).to be_empty
  end
end