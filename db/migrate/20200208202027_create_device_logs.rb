class CreateDeviceLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :device_logs do |t|
      t.references :device, null: false, foreign_key: true
      t.jsonb :data, :null => false, :default => {}
    end
  end
end
