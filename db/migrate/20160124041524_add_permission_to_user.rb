class AddPermissionToUser < ActiveRecord::Migration
  def change
    add_column :users, :manage_user, :boolean, default: false
    add_column :users, :manage_campaign, :boolean, default: false
  end
end
