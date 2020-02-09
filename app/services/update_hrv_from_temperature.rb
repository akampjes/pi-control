class UpdateHrvFromTemperature
  TARGET_TEMPERATURE = 20.0

  def initialize(relay_switch:, input_sensor:, output_sensor:)
    @relay_switch = relay_switch
    @input_sensor = input_sensor
    @output_sensor = output_sensor
  end

  def call
    input_log = @input_sensor.most_recent_first.first
    output_log = @output_sensor.most_recent_first.first

    switch_state = @relay_switch.current_state

    return unless input_log.present? && output_log.present?

    input_temperature = input_log.data['temperature'].to_i
    output_temperature = output_log.data['temperature'].to_i

    temp_difference = input_temperature - output_temperature
    # Negative temperature difference means that it's cooler at the input sensor

    if output_temperature > TARGET_TEMPERATURE && temp_difference < 0
      # It's too warm at the output, and it's cooler at the input

      if switch_state != RelaySwitch.STATE_ON
        @relay_switch.on!

        # Early return after switching the HRV on
        return true
      end
    end

    if switch_state != RelaySwitch.STATE_OFF
      @relay_switch.off!
    end
  end
end