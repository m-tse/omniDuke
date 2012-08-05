class RenameWaitListCountToWaitListEnrollment < ActiveRecord::Migration
  def change
    rename_column :sections, :waitlist_count, :waitlist_enrollment
  end
end
