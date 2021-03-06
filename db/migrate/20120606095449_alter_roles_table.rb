class AlterRolesTable < ActiveRecord::Migration
  def up
    rename_column :roles, :video_id_id, :video_id
    remove_column :roles, :show_id
    add_column :roles, :person_id, :integer
    add_index :roles, :video_id
    add_index :roles, :person_id
  end

  def down
    remove_index :roles, :video_id
    remove_index :roles, :person_id
    add_column :roles, :show_id, :integer
    remove_column :roles, :person_id
    rename_column :roles, :video_id, :video_id_id
    add_index :roles, :role
  end
end
