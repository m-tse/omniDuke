module ApplicationHelper
  def capitalize(str)
    retstring = ""
    for part in str.split
      retstring=retstring+part.capitalize!+ " "
    end
    return retstring.strip
  end

  def courseToString(course)
    courseToCode(course)+" "+course.name
  end

  def courseToCode(course)
    course.subject.abbr+course.new_number+"/"+course.old_number
  end
end
