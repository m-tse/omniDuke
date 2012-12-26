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

  def omni_search_help_text
    "Search by keywords to find courses and professors, e.g., type 'dance' to find courses about dance!  I'm smart enough to figure it out for you."
  end
end
