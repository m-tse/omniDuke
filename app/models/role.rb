class Role < ActiveRecord::Base
   attr_accessible :role
  belongs_to :instructor
  belongs_to :course
end
