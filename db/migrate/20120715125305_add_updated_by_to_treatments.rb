class AddUpdatedByToTreatments < ActiveRecord::Migration
  def change
    add_column :treatments, :updated_by, :string
  end
end
