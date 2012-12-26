class Schedulator < ActiveRecord::Base
    belongs_to :user
    has_many :schedule_relationship
    has_many :sections, through: :schedule_relationship
end
