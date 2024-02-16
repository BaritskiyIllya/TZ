class CreateExperimentsOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :experiments_options do |t|
      t.references :experiment, null: false, foreign_key: true
      t.json :options
      t.float :max_percentage

      t.timestamps
    end
  end
end
