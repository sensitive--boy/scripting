class CreateChosenItems < ActiveRecord::Migration
  def change
    create_table :chosen_items do |t|
      t.references :technical_item
      t.references :video

      t.timestamps
    end
    add_index :chosen_items, :technical_item_id
    add_index :chosen_items, :video_id
  end
end
