class RemoveChosenFromTechnicalItems < ActiveRecord::Migration
  def up
    remove_column :technical_items, :chosen
  end

  def down
    add_column :technical_items, :chosen, :boolean
  end
end
