class CreateTemperatures < ActiveRecord::Migration[7.0]
  def change
    create_table :temperatures do |t|
      t.integer :epoch_time
      t.timestamp :local_observation_time
      t.float :temperature

      t.timestamps
    end
  end
end
