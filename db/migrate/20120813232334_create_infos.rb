class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :name
      t.string :function
      t.string :addition
      t.references :szene

      t.timestamps
    end
    add_index :infos, :szene_id
  end
end
