module SchedulatorHelper

    def getActiveClass(active, index)
        if active.nil?
            return
        elsif (active == "new" && index == 1) || (active == "saved" && index == 2) 
            return "active" 
        end
    end

    # Get ScheduleRelationship ID for given
    # schedulator and section
    def getRelationshipId(schedulator, section)
        return ScheduleRelationship.where("""
            schedulator_id = #{schedulator.id} 
            AND section_id = #{section.id}
            """)[0].id
    end


end
