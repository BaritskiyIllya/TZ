class CreateDeviceExperiments < ActiveRecord::Migration[6.0]
  def change
    create_table :device_experiments do |t|
      t.references :device, null: false, foreign_key: true
      t.references :experiments_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
