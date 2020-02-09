class UpdateHrvStateJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    switch = RelaySwitch.find_by_name('HRV')

    input_sensor = TemperatureSensor.find_by_name('Playroom sensor')
    output_sensor = TemperatureSensor.find_by_name('Bedroom sensor')

    UpdateHrvFromTemperature.new(relay_switch: switch,
                                 input_sensor: input_sensor,
                                 output_sensor: output_sensor).call
  end
end
