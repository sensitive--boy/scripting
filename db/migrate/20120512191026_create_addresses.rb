class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :venue
      t.string :addition
      t.string :address
      t.string :city
      t.string :country
      t.string :zip
      t.references :person

      t.timestamps
    end
    add_index :addresses, :person_id
  end
end
