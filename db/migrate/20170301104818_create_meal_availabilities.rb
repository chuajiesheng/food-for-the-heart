class CreateMealAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :meal_availabilities do |t|
      t.datetime :availability_for
      t.integer :chicken
      t.integer :mutton
      t.integer :beef
      t.integer :fish
      t.integer :prawn
      t.integer :squid

      t.timestamps
    end
  end
end
