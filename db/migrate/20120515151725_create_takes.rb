class CreateTakes < ActiveRecord::Migration
  def change
    create_table :takes do |t|
      t.text :view_desc
      t.text :audio_desc
      t.integer :duration
      t.integer :position
      t.string :note
      t.references :szene

      t.timestamps
    end
    add_index :takes, :szene_id
  end
end
