class RenameSectionIdToTimeslotId < ActiveRecord::Migration
  def change
    rename_column :sections, :section_id, :time_slot_id
  end
end
