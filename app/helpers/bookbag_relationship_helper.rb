module BookbagRelationshipHelper

    def getBookbagRelationshipId(user, course)
        return BookbagRelationship.where("""
            user_id = #{user.id} 
            AND course_id = #{course.id}
            """)[0].id
    end

end
