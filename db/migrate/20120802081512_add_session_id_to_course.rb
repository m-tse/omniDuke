class AddSessionIdToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :session_id, :integer
  end
end
