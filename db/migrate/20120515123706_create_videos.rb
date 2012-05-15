class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :format
      t.integer :supposed_duration
      t.integer :duration
      t.text :summary
      t.integer :show_id
      t.references :person

      t.timestamps
    end
    add_index :videos, :person_id
  end
end
