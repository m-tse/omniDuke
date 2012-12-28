module ActiveSchedulatorRelationshipsHelper

    def getActiveSchedulatorRelationshipId(user, schedulator)
        return ActiveSchedulatorRelationship.where("""
            user_id = #{user.id} 
            AND schedulator_id = #{schedulator.id}
            """)[0].id
    end

end
