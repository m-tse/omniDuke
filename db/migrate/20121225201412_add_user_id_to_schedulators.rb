class AddUserIdToSchedulators < ActiveRecord::Migration
  def change
    add_column :schedulators, :user_id, :integer
  end
end
