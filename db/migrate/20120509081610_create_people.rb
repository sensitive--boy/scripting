class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :firstname
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :messenger
      t.references :user
      t.references :admin
      t.integer :video_id

      t.timestamps
    end
    add_index :people, :user_id
    add_index :people, :admin_id
  end
end
