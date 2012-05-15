class RemovePersonIdColumnFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :person_id
  end

  def down
    add_column :videos, :person_id, :integer
  end
end
