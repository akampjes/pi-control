class DashboardController < ApplicationController
  def show
  end

  def create
    switch = RelaySwitch.find_by_name('HRV')

    if params[:commit] == 'ON'
      switch.on!
    elsif params[:commit] == 'OFF'
      switch.off!
    end

    redirect_to dashboard_path
  end
end
