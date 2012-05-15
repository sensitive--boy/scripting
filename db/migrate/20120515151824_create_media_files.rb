class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.string :description
      t.string :origin
      t.references :szene

      t.timestamps
    end
    add_index :media_files, :szene_id
  end
end
