class AddTimestampsToDeviceLogs < ActiveRecord::Migration[6.0]
  def change
    DeviceLog.all.delete_all

    change_table :device_logs do |t|
      t.timestamps
    end
  end
end
