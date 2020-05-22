require 'rails_helper'

RSpec.describe RelaySwitch do
  subject(:relay_switch) { RelaySwitch.create(name: 'device name', configuration: { pin: 26}) }

  describe "on!" do
    before do
      allow_any_instance_of(Kernel).to receive(:sleep)
      expect_any_instance_of(Kernel).to receive(:system).at_least(:once)
    end

    it 'turns on' do
      expect do
        relay_switch.on!
      end.to change { DeviceLog.count }.by 1
    end
  end

  describe "override_on!" do
    before do
      allow_any_instance_of(Kernel).to receive(:sleep)
      expect_any_instance_of(Kernel).to receive(:system).at_least(:once)
    end

    it 'turns on and sets configuration to on' do
      expect do
        relay_switch.override_on!
      end.to change { DeviceLog.count }.by 1

      expect(relay_switch.configuration['state']).to eq RelaySwitch::STATE_ON
    end
  end


  describe "off!" do
    before do
      allow_any_instance_of(Kernel).to receive(:sleep)
      expect_any_instance_of(Kernel).to receive(:system).at_least(:once)
    end

    it 'turns off' do
      expect do
        relay_switch.off!
      end.to change { DeviceLog.count }.by 1
    end
  end

  describe "override_off!" do
    before do
      allow_any_instance_of(Kernel).to receive(:sleep)
      expect_any_instance_of(Kernel).to receive(:system).at_least(:once)
    end

    it 'turns off and sets configuration to off' do
      expect do
        relay_switch.override_off!
      end.to change { DeviceLog.count }.by 1

      expect(relay_switch.configuration['state']).to eq RelaySwitch::STATE_OFF
    end
  end


  describe "auto!" do
    it 'sets to auto mode' do
      expect do
        relay_switch.auto!
      end.to change { DeviceLog.count }.by 1

      expect(relay_switch.configuration['state']).to eq RelaySwitch::STATE_AUTO
    end
  end
end