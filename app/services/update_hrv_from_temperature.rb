class UpdateHrvFromTemperature
  TARGET_TEMPERATURE = 20.0

  def initialize(relay_switch:, input_sensor:, output_sensor:)
    @relay_switch = relay_switch
    @input_sensor = input_sensor
    @output_sensor = output_sensor
  end

  def call
    input_log = @input_sensor.device_logs.most_recent_first.first
    output_log = @output_sensor.device_logs.most_recent_first.first

    switch_state = @relay_switch.current_state

    return unless input_log.present? && output_log.present?

    input_temperature = input_log.data['temperature'].to_i
    output_temperature = output_log.data['temperature'].to_i

    temp_difference = input_temperature - output_temperature
    # Negative temperature difference means that it's cooler at the input sensor
    Rails.logger.debug "input_temp: #{input_temperature}"
    Rails.logger.debug "output_temp: #{output_temperature}"
    Rails.logger.debug "temp_diff: #{temp_difference}"
    Rails.logger.debug "switch_state: #{switch_state}"

    if output_temperature > TARGET_TEMPERATURE && temp_difference < 0
      # It's too warm at the output, and it's cooler at the input

      Rails.logger.debug "** here1"
      if switch_state != RelaySwitch::STATE_ON
        Rails.logger.debug "** here2"
        @relay_switch.on!
      end

      Rails.logger.debug "** here3"
      # Early return after ensuring the HRV is on
      return true
    end

    Rails.logger.debug "** here4"
    if switch_state != RelaySwitch::STATE_OFF
      Rails.logger.debug "** here5"
      @relay_switch.off!
    end
  end
end