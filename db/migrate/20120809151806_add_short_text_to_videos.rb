class AddShortTextToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :short_text, :text
    rename_column :videos, :advise, :hint
  end
end
