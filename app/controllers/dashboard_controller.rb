class DashboardController < ApplicationController
  def show
  end

  def create
    system('echo 26 > /sys/class/gpio/export')
    sleep(1) # Sleep because the system takes a tick to update

    system('echo out > /sys/class/gpio/gpio26/direction')
    sleep(1) # Sleep because the system takes a tick to update

    if params[:commit] == 'ON'
      system('echo 0 > /sys/class/gpio/gpio26/value')
    elsif params[:commit] == 'OFF'
      system('echo 0 > /sys/class/gpio/gpio26/value')
    end

    redirect_to dashboard_path
  end
end