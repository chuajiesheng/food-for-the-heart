class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.references :user, foreign_key: true
      t.boolean :chicken
      t.boolean :mutton
      t.boolean :beef
      t.boolean :fish
      t.boolean :prawn
      t.boolean :squid

      t.timestamps
    end
  end
end
