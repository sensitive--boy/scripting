class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
      t.text :text
      t.string :main_characteristc
      t.string :conflict
      t.string :development
      t.string :storyline
      t.string :place
      t.text :first_szene_desc
      t.string :moral
      t.string :keywords
      t.references :video

      t.timestamps
    end
    add_index :treatments, :video_id
  end
end
