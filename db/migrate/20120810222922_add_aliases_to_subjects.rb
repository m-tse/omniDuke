class AddAliasesToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :aliases, :text
  end
end
