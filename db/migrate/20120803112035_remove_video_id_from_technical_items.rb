class RemoveVideoIdFromTechnicalItems < ActiveRecord::Migration
  def up
    remove_column :technical_items, :video_id
  end

  def down
    add_column :technical_items, :video_id, :integer
  end
end
