class AddNameIndexToSessions < ActiveRecord::Migration
  def change
    add_index :sessions, :name, unique: true
  end
end
