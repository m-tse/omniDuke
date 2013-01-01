module ScheduleRelationshipHelper

    def getScheduleRelationship(schedulator, section)
        return ScheduleRelationship.where("""
            schedulator_id = #{schedulator.id} 
            AND section_id = #{section.id}
            """)[0]
    end

    def getIds(models)
        ids = Array.new
        models.each do |mod|
            ids << mod.id
        end
        return ids
    end

end
