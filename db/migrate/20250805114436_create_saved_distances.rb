class CreateSavedDistances < ActiveRecord::Migration[8.0]
  def change
    create_table :saved_distances do |t|
      t.float :distance
      t.json :flight_distance
      t.float :car_distance
      t.belongs_to :from, foreign_key: { to_table: :places }
      t.belongs_to :to, foreign_key: { to_table: :places }
      t.timestamps
    end
  end
end
