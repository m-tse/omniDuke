class ChangeColumnsForAttributes < ActiveRecord::Migration
  def change
    add_column :course_attributes, :scrape_value, :string
  end
end
