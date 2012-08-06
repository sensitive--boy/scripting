class AddVideoIdToTechnicalItems < ActiveRecord::Migration
  def change
    add_column :technical_items, :video_id, :integer
  end
end
