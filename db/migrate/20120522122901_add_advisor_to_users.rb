class AddAdvisorToUsers < ActiveRecord::Migration
  def change
    change_column :users, :advisor, :boolean, :default=>false
  end
end
