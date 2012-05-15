class CreateSequences < ActiveRecord::Migration
  def change
    create_table :sequences do |t|
      t.string :name
      t.integer :position
      t.references :video

      t.timestamps
    end
    add_index :sequences, :video_id
  end
end
