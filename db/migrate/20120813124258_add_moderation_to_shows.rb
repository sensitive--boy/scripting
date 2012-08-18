class AddModerationToShows < ActiveRecord::Migration
  def change
    add_column :shows, :moderation, :text
    add_column :shows, :short_text, :text
  end
end
