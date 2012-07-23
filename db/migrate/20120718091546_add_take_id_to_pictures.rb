class AddTakeIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :take_id, :integer
  end
end
