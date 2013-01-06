class RenameAccessbilityToAccessibility < ActiveRecord::Migration
  def up
  	rename_column :instructor_reviews, :accessbility, :accessibility
  end

  def down
  end
end
