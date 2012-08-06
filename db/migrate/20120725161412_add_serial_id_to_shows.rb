class AddSerialIdToShows < ActiveRecord::Migration
  def change
    add_column :shows, :serial_id, :integer
  end
end
