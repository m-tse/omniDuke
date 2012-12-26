module SchedulatorHelper

    # Used to be used, now using isActiveClass()
    # Remove if you so choose
    def getActiveClass(active, index)
        if active.nil?
            return "inactive"
        elsif (active == "new" && index == 1) || (active == "saved" && index == 2) 
            return "active" 
        end
    end

    def isActiveClass(active, index)
        if active.nil?
            return false
        elsif (active == "new" && index == 1) || (active == "saved" && index == 2) 
            return true
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
