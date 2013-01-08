class AddViewDetailToSections < ActiveRecord::Migration
  def change
    add_column :sections, :view_detail, :string
  end
end
