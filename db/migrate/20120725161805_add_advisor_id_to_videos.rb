class AddAdvisorIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :advisor_id, :integer
  end
end
