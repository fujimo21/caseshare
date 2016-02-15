class CreateSuitcases < ActiveRecord::Migration
  def change
    create_table :suitcases do |t|
      t.string :case_type
      t.string :case_size
      t.boolean :has_key
      t.text :summary
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
