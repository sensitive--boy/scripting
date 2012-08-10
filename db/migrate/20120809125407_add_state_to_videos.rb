class AddStateToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :state, :string
    add_column :videos, :advise, :string
  end
end
