class FixUnitsInSections < ActiveRecord::Migration
  def change
    remove_column :sections, :parsedUnits
    add_column :sections, :units, :decimal
  end
end
