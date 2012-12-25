class ScheduleRelationship < ActiveRecord::Base
    belongs_to :schedulator, foreign_key: "schedulator_id"
    belongs_to :section, foreign_key: "section_id"
end
