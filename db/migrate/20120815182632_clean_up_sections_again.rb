class CleanUpSectionsAgain < ActiveRecord::Migration
  def change
    remove_column :sections, :suffix
  end
end
