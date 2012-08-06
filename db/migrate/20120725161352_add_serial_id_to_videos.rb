class AddSerialIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :serial_id, :integer
  end
end
