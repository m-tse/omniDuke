module ScheduleRelationshipHelper

    def getScheduleRelationship(schedulator, section)
        return ScheduleRelationship.where("""
            schedulator_id = #{schedulator.id} 
            AND section_id = #{section.id}
            """)[0]
    end

end
