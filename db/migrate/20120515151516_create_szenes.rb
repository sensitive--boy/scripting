class CreateSzenes < ActiveRecord::Migration
  def change
    create_table :szenes do |t|
      t.string :place
      t.text :description
      t.string :title
      t.integer :position
      t.references :sequence

      t.timestamps
    end
    add_index :szenes, :sequence_id
  end
end
