class Schedulator < ActiveRecord::Base
    belongs_to :user
    has_many :schedulator_relationship
    has_many :sections, through: :schedulator_relationship
end
