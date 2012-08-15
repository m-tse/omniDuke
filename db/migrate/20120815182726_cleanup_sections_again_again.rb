class CleanupSectionsAgainAgain < ActiveRecord::Migration
  def change
    remove_column :sections, :location
    remove_column :sections, :credits
  end
end
