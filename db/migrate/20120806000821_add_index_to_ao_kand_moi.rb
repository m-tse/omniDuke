class AddIndexToAoKandMoi < ActiveRecord::Migration
  def change
    add_index :modes_of_inquiries, :abbr, unique: true
    add_index :areas_of_knowledges, :abbr, unique: true
  end
end
