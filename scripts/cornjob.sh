#/bin/bash

export HOME=/home/pi
export RAILS_ENV=production
export RBENV_ROOT=$HOME/.rbenv
export RBENV_VERSION=2.6.5

cd /home/pi/apps/pi-control/current
$HOME/.rbenv/bin/rbenv exec bundle exec rake job:read_temperatures
$HOME/.rbenv/bin/rbenv exec bundle exec rake job:update_hrv_state
