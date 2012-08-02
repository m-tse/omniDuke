class CreateModesOfInquiries < ActiveRecord::Migration
  def change
    create_table :modes_of_inquiries do |t|
      t.string :name
      t.string :abbr

      t.timestamps
    end
  end
end
