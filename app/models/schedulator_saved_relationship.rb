class SchedulatorSavedRelationship < ActiveRecord::Base
    belongs_to :user, foreign_key: "user_id"
    belongs_to :schedulator, foreign_key: "schedulator_id"
end
