class RenameCharacteristicColumnTreatment < ActiveRecord::Migration
  def up
    rename_column :treatments, :main_characteristc, :main_characteristic
  end

  def down
    rename_column :treatments, :main_characteristic, :main_characteristc
  end
end
