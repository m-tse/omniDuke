class RemoveINdex < ActiveRecord::Migration
  def up
    remove_index :subjects, :name=> 'index_subjects_on_name'
  end

  def down
  end
end
