class AddListingnameToSuitcase < ActiveRecord::Migration
  def change
    add_column :suitcases, :listing_name, :string
  end
end
