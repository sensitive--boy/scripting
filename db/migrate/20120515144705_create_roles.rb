class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role
      t.integer :show_id
      t.references :video_id

      t.timestamps
    end
    add_index :roles, :video_id_id
  end
end
