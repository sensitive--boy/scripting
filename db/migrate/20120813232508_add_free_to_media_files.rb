class AddFreeToMediaFiles < ActiveRecord::Migration
  def change
    add_column :media_files, :free_to_use, :boolean
  end
end
