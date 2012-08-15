class AddMoreColumnsToSections < ActiveRecord::Migration
  def change



    remove_column :sections :suffix


  end
end
