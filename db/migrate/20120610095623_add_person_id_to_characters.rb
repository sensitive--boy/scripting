class AddPersonIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :person_id, :integer
  end
end
