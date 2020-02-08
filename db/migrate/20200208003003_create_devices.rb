class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.text :type
      t.text :name
      t.jsonb :configuration, :null => false, :default => {}
    end
  end
end
