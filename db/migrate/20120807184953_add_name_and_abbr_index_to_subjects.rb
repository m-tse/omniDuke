class AddNameAndAbbrIndexToSubjects < ActiveRecord::Migration
  def change
    add_index :subjects, :abbr, unique: true
    add_index :subjects, :name, unique: true
  end
end
