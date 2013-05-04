class CreateVidposts < ActiveRecord::Migration
  def change
    create_table :vidposts do |t|
      t.string :vid_id
      t.integer :user_id

      t.timestamps
    end
    add_index :vidposts, [:user_id, :created_at]
  end

end
