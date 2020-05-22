class DashboardController < ApplicationController
  def show
    @input_sensor = TemperatureSensor.find_by_name('Playroom sensor')
    @output_sensor = TemperatureSensor.find_by_name('Bedroom sensor')
    @switch = RelaySwitch.find_by_name('HRV')
  end

  def create
    switch = RelaySwitch.find_by_name('HRV')

    if params[:commit] == 'ON'
      switch.override_on!
    elsif params[:commit] == 'OFF'
      switch.override_off!
    elsif params[:commit] == 'AUTO'
      switch.auto!
    end

    redirect_to dashboard_path
  end
end
