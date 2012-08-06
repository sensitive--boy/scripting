class AddPropsToSzenes < ActiveRecord::Migration
  def change
    add_column :szenes, :props, :string
  end
end
