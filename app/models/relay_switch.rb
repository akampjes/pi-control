class RelaySwitch < Device
  STATE_OFF = 'off'
  STATE_ON  = 'on'

  # Authorative record of the current state
  #
  def current_state
    # Enable this pin
    system("echo #{pin} > /sys/class/gpio/export")
    sleep(0.5)

    out, err, st = Open3.capture3('cat /sys/class/gpio/gpio26/value')

    out.chomp

    if out == '1'
      STATE_OFF
    elsif out == '0'
      STATE_ON
    else
      nil # No current state, must not have been initialised
    end
  end

  # We want to use this to display the current state in the UI, rather than
  # calling system commands every time we visit a page.
  #
  def most_recent_state
    log = DeviceLog.where(device: self).order(created_at: :desc).first

    if log
      log.data['state']
    else
      # Fallback to querying the current state
      #
      current_state
    end
  end

  def on!
    system("echo #{pin} > /sys/class/gpio/export")
    sleep(1) # Sleep because the system takes a tick to update

    system("echo out > /sys/class/gpio/gpio#{pin}/direction")
    sleep(1) # Sleep because the system takes a tick to update

    system("echo 0 > /sys/class/gpio/gpio#{pin}/value")

    DeviceLog.create!(device: self, data: { state: STATE_ON })
  end

  def off!
    system("echo #{pin} > /sys/class/gpio/export")
    sleep(1) # Sleep because the system takes a tick to update

    system("echo out > /sys/class/gpio/gpio#{pin}/direction")
    sleep(1) # Sleep because the system takes a tick to update

    system("echo 1 > /sys/class/gpio/gpio#{pin}/value")

    DeviceLog.create!(device: self, data: { state: STATE_OFF })
  end

  private

  def pin
    configuration['pin']
  end
end