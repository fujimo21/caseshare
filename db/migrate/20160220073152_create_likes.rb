class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true
      t.references :suitcase, index: true

      t.timestamps null: false
      
      t.index [:user_id, :suitcase_id], unique: true
    end
  end
end
