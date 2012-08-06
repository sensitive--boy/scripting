class AddUsernameToTechnicians < ActiveRecord::Migration
  def change
    add_column :technicians, :username, :string
  end
end
