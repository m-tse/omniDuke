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
  def omni_search_help_text
    "Search by keywords to find courses and professors, e.g., type 'dance' to find courses about dance!  I'm smart enough to figure it out for you."
  end
end
