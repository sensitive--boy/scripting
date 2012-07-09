class AddTakeIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :take_id, :integer
  end
end
