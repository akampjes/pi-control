namespace :job do
  desc 'Read temperature form TemperatureSensor devices'
  task :read_temperatures => :environment do
    TemperatureSensor.pluck(:id).each do |device_id|
      # Can't really use `perform_later` here as we don't have an external job runner
      #
      LogTemperatureJob.perform_now(device_id)
    end
  end
end