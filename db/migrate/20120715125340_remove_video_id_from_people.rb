class RemoveVideoIdFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :video_id
  end

  def down
    add_column :people, :video_id, :integer
  end
end
