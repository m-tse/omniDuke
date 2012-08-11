class AddAliasesToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :alias, :string
  end
end
