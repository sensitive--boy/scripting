class AddVideoAndShowIdsToUser < ActiveRecord::Migration
  def change
    add_column :users, :video_id, :integer
    add_column :users, :show_id, :integer
  end
end
