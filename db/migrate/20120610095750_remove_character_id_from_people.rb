class RemoveCharacterIdFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :character_id
  end

  def down
    add_column :people, :character_id, :integer
  end
end
