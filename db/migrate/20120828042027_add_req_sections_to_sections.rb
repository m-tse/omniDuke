class AddReqSectionsToSections < ActiveRecord::Migration
  def change
    add_column :sections, :required_sections, :string
  end
end
