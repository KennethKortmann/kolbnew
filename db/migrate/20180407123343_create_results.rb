class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.text :name
      t.text :very_strong_pref
      t.text :strong_pref
      t.text :moderat_pref
      t.text :low_pref
      t.text :very_low_pref

      t.timestamps
    end
  end
end
