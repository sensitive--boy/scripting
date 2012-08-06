class AddChosenToTechnicalItems < ActiveRecord::Migration
  def change
    add_column :technical_items, :chosen, :boolean, :default => false
  end
end
