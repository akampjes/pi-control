class UpdateHrvFromTemperature
  TARGET_TEMPERATURE = 22.0

  def initialize(relay_switch:, input_sensor:, output_sensor:)
    @relay_switch = relay_switch
    @input_sensor = input_sensor
    @output_sensor = output_sensor
  end

  def call
    input_log = @input_sensor.device_logs.most_recent_first.first
    output_log = @output_sensor.device_logs.most_recent_first.first

    switch_state = @relay_switch.current_state

    # If the Pi has been reset, we want to pick up the most
    # recent state that's been configured.
    #
    # If there is no manual override, then we must be on auto mode
    # and we continue with this method.
    #
    case @relay_switch.configuration['state']
    when RelaySwitch::STATE_ON
      @relay_switch.on! unless RelaySwitch::STATE_ON
      return true
    when RelaySwitch::STATE_OFF
      @relay_switch.off! unless RelaySwitch::STATE_OFF
      return true
    when RelaySwitch::STATE_AUTO
      # Continue
    else
      # NOP
    end

    return unless input_log.present? && output_log.present?

    input_temperature = input_log.data['temperature'].to_i
    output_temperature = output_log.data['temperature'].to_i

    temp_difference = input_temperature - output_temperature
    # Negative temperature difference means that it's cooler at the input sensor
    # Positive temperature difference means that it's warmer at the input sensor
    Rails.logger.debug "input_temp: #{input_temperature}"
    Rails.logger.debug "output_temp: #{output_temperature}"
    Rails.logger.debug "temp_diff: #{temp_difference}"
    Rails.logger.debug "switch_state: #{switch_state}"

    if TARGET_TEMPERATURE > output_temperature && temp_difference > 0
      # It's too cold at the output, and it's warmer at the input

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
