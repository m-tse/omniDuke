#Gets the pre-existing instructor with the name, or creates a new one if that instructor does not yet exist
def getCreateInstructor(name)
    foundInstructor = Instructor.find_by_name(name)
  if foundInstructor!=nil
    return foundInstructor
  else
    return Instructor.create!(name: name)
  end
end

def getCreateSubject(nameString, abbrString)
  foundSubjectByName = Subject.find_by_name(nameString.downcase)
  foundSubjectByAbbr = Subject.find_by_abbr(abbrString.upcase)
  if (foundSubjectByName != nil and foundSubjectByAbbr != nil and foundSubjectByName==foundSubjectByAbbr)
    return foundSubjectByName
  else
    return Subject.create!(name: nameString, abbr: abbrString)
  end
end

def getCreateSession(season, year)
  foundSession = Session.find_by_season_and_year(season, year)
  if(foundSession !=nil)
    return foundSession
  else
    return Session.create!(season: season, year: year)
  end
end

def setSectionTimeSlot(section, dayArray, startTimeString, endTimeString)
  timeslot = TimeSlot.new

  for day in dayArray
    timeslot.days_of_week << day
  end

  timeslot.start_time = Time.parse(startTimeString)
  timeslot.end_time = Time.parse(endTimeString)

  timeslot.save
  timeslot.sections << section
end

def getCreateCourseAttribute(scrapedvalue)
  scrapedvalue = scrapedvalue.strip
  foundAttribute = CourseAttribute.find_by_scrape_value(scrapedvalue)
  if(foundAttribute != nil)
    return foundAttribute
  else
    return CourseAttribute.create!(scrape_value:scrapedvalue)
  end
end

def getCreateTimeSlot(scrapedACESValue)
  foundTimeSlot = TimeSlot.find_by_aces_value(scrapedACESValue)
  if(foundTimeSlot !=nil)
    return foundTimeSlot
  else 
    return TimeSlot.create!(aces_value:scrapedACESValue)
  end
end

def getBuildCourse(currentSubject, currentSession, new_number, old_number)
  foundCourse = Course.find_by_subject_id_and_session_id_and_new_number_and_old_number(currentSubject.id, currentSession.id, new_number, old_number)
  if foundCourse !=nil
    return foundCourse
  else
    newCourse =  Course.new(new_number:new_number, old_number:old_number)
    newCourse.session=currentSession
    newCourse.subject=currentSubject
    return newCourse
  end
end
