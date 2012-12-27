module BookbagRelationshipHelper

    def getBookbagRelationshipId(user, section)
        return BookbagRelationship.where("""
            user_id = #{user.id} 
            AND section_id = #{section.id}
            """)[0].id
    end

end
