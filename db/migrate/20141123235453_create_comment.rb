class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :username
    	t.text :content
    	t.references :user
    	t.references :location
    	
    	t.timestamps
    end
  end
end
