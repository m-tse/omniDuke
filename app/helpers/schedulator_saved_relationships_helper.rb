module SchedulatorSavedRelationshipsHelper

    def getSchedulatorSavedRelationship(user, schedulator)
        return SchedulatorSavedRelationship.where("""
            user_id = #{user.id} AND 
            schedulator_id = #{schedulator.id}
        """)[0]
    end

end
