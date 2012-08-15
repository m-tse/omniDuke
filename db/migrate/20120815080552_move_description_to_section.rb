class MoveDescriptionToSection < ActiveRecord::Migration
  def change
    remove_column :courses, :description
    add_column :sections, :description, :text
    
    remove_column :courses, :synopsis
    add_column :sections, :synopsis, :text

    remove_column :courses, :credits
    add_column :sections, :credits, :decimal

    remove_column :courses, :seminar
  end
end
