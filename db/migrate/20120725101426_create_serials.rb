class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :title
      t.text :description
      t.boolean :for_shows, :default => 0

      t.timestamps
    end
  end
end
