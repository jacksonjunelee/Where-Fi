class AddFavPointToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :fav_point, :integer
  end
end
