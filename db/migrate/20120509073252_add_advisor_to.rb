class AddAdvisorTo < ActiveRecord::Migration
  def up
    add_column :users, :advisor, :boolean, :default => false
  end

  def down
    remove_column :users, :advisor
  end
end
