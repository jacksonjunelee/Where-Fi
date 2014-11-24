class CreateJoinTableLocationsUsers < ActiveRecord::Migration
  def change
    create_join_table :locations, :users do |t|
      # t.index [:location_id, :user_id]
      # t.index [:user_id, :location_id]
    end
  end
end
