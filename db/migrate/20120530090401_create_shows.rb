class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.datetime :date
      t.string :title
      t.string :toppic
      t.integer :duration
      t.references :user

      t.timestamps
    end
    add_index :shows, :user_id
  end
end
