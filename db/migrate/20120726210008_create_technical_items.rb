class CreateTechnicalItems < ActiveRecord::Migration
  def change
    create_table :technical_items do |t|
      t.string :name
      t.string :identifier
      t.text :description
      t.boolean :available
      t.string :manual
      t.datetime :date_of_purchase

      t.timestamps
    end
  end
end
