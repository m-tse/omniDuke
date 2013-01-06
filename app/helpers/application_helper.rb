module ApplicationHelper
  def capitalize(str)
    retstring = ""
    for part in str.split
      retstring=retstring+part.capitalize!+ " "
    end
    return retstring.strip
  end

  def courseToString(course)
    course.subject.abbr+" "+courseToCode(course)+" "+course.name
  end

  def courseToCode(course)
    retString = ""
    if course.new_number != nil
      retString+=course.new_number
    end
    if(course.old_number!=nil)
      if(course.new_number!=nil)
        retString+="/"
      end
      retString+=course.old_number
    end
    retString
  end

  def courseToStringWithoutSubject(course)
    courseToCode(course)+" "+course.name
  end


  #10 levesl of colors from red to yellow to green
  def color_gradient
    ['#EE5F5B','#F17059', '#F68254', '#F8A352', '#FBB450', '#DCB754', '#BEBA57', '#9FBE5B', '#81C15E', '#62C462']
  end
end
