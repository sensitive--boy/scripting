class AddAddressIdToTake < ActiveRecord::Migration
  def change
    add_column :takes, :address_id, :integer
  end
end
