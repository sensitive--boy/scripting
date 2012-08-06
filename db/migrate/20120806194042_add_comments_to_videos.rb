class AddCommentsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :comments, :text
  end
end
