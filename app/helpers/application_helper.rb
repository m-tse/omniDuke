module ApplicationHelper
  def capitalize(str)
    retstring = ""
    for part in str.split
      retstring=retstring+part.capitalize!+ " "
    end
    return retstring.strip
  end
end
