class ScheduleRelationship < ActiveRecord::Base
    attr_accessible :conflicting
    belongs_to :schedulator, foreign_key: "schedulator_id"
    belongs_to :section, foreign_key: "section_id"
end
