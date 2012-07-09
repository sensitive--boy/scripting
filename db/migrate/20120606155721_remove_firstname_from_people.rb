class RemoveFirstnameFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :firstname
  end

  def down
    add_column :people, :firstname, :string
  end
end
