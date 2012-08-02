class AddCreditsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :credits, :decimal
    remove_column :courses, :semester
  end
end
