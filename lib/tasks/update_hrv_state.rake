namespace :job do
  desc 'Evaluate and Update the HRV state'
  task :update_hrv_state => :environment do
    # Can't really use `perform_later` here as we don't have an external job runner
    #

    switch          = RelaySwitch.find_by_name('HRV')
    most_recent_log = switch.device_logs.most_recent_first.first

    # Early return if we if we only changed the HRV recently
    return if most_recent_log && most_recent_log.created_at > 15.minutes.ago

    UpdateHrvStateJob.perform_now
  end
end