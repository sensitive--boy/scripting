class CreateAudiotracks < ActiveRecord::Migration
  def change
    create_table :audiotracks do |t|
      t.string :interpreter
      t.string :album
      t.string :title
      t.integer :fraction_length
      t.references :szene

      t.timestamps
    end
    add_index :audiotracks, :szene_id
  end
end
