class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :charactername
      t.references :treatment

      t.timestamps
    end
    add_index :characters, :treatment_id
  end
end
