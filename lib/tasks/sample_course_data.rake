namespace :db do
  desc "Fill course database with sample data, later on to be retrieved through       web scraping, serves as a model for how to fill out the data"	
  task populate: :environment do
    subjectsHash = {"COMPSCI"=>"Computer Science", "CLST"=> "Classical Studies",      "CHINESE"=>"Chinese"}
    subjectsHash.each_pair do |k,v|
      if(Subject.find_by_name(v)==nil)
        Subject.create!(abbr:k, name:v)
      end
    end
    createDuvall
    createDepartmentStaff
    createAstrachan
    createfall2012
    createcs6	
    createcs100
    createcs108



  end
end

def getCreateInstructor(name)
    foundInstructor = Instructor.find_by_name(name.downcase)
  if foundInstructor!=nil
    return foundInstructor
  else
    return Instructor.create!(name: name.downcase)
  end
end

def createfall2012
  Session.create!(year:2012, season:"fall")
end
def createDuvall
  getCreateInstructor("Robert Duvall")
end
def createDepartmentStaff
  getCreateInstructor("Departmental Staff")
end
def createAstrachan
  getCreateInstructor("Owen Astrachan")
end

def createcs6
  cs6 = Course.new(name:"Introduction to Computer Science", credits:1)
  cs6.description = "Introduction practices and principles of computer science and programming and their impact on and potential to change the world. Algorithmic, problem-solving, and programming techniques in domains such as art, data visualization, mathematics, natural and social sciences. Programming using high-level languages and design techniques emphasizing abstraction, encapsulation, and problem decomposition. Design, implementation, testing, and analysis of algorithms and programs. No previous programming experience required."
  cs6.save
  lec = cs6.sections.create!(section_type:"LEC", suffix:"001",
                               location:"L.S.R.C. B101", enrollment:226,
                               capacity:240, waitlist_enrollment:4,
                             waitlist_capacity:200,  class_number:1703)
  lec.instructors << getCreateInstructor("Owen Astrachan")
  timeslot = TimeSlot.new
  timeslot.days_of_week<< 1
  timeslot.days_of_week << 3
  timeslot.start_time=Time.new.change(hour:13, min:25)
  timeslot.end_time = Time.new.change(hour:14, min:40)
  timeslot.save
  timeslot.sections<< lec

  lab = cs6.sections.create!(section_type:"LAB", suffix:"01L", 
                             location:"Languages 109", enrollment:30, 
                             capacity:30, waitlist_enrollment:4, 
                             waitlist_capacity:25, class_number:1704)
  lab.instructors << getCreateInstructor("Owen Astrachan")
  timeslot = TimeSlot.new
  timeslot.days_of_week<< 3
  timeslot.start_time=Time.new.change(hour:15, min:5)
  timeslot.end_time = Time.new.change(hour:16, min:20)
  timeslot.save
  timeslot.sections<< lab


  cs6.areas_of_knowledge << AreasOfKnowledge.find_by_abbr("QS")
  cs6.subjects << Subject.find_by_abbr("COMPSCI")
  cs6.save
  cn=cs6.course_numberings.first
  cn.old_number = "6L"
  cn.new_number = "101L"
  cn.save
  cs6.session=Session.find_by_name("fall2012")
  cs6.save
end


def createcs100
  cs100=Course.new(name:"Data Structures and Algorithms", 
                   credits:1)
  cs100.prerequisites<< Course.find_by_name("Introduction to Computer Science")
  cs100.description = "Analysis, use, and design of data structures and algorithms using an object-oriented language like Java to solve computational problems. Emphasis on abstraction including interfaces and abstract data types for lists, trees, sets, tables/maps, and graphs. Implementation and evaluation of programming techniques including recursion. Intuitive and rigorous analysis of algorithms."
  cs100.areas_of_knowledge << AreasOfKnowledge.find_by_abbr("QS")
  cs100.save

  lec = cs100.sections.create!(section_type:"LEC", suffix:"001",
                               location:"L.S.R.C. B101", enrollment:123,
                               capacity:180, waitlist_enrollment:0,
                               waitlist_capacity:180, class_number:1714)
  lec.instructors << getCreateInstructor("Departmental Staff")
  timeslot = TimeSlot.new
  timeslot.days_of_week<< 1
  timeslot.days_of_week << 3
  timeslot.start_time=Time.new.change(hour:10, min:5)
  timeslot.end_time = Time.new.change(hour:11, min:20)
  timeslot.save
  timeslot.sections<< lec

  rec = cs100.sections.create!(section_type:"REC", suffix:"01R",
                               location:"L.S.R.C. B101", enrollment:123,
                               capacity:180, waitlist_enrollment:0,
                               waitlist_capacity:180, class_number:1715)
  rec.instructors << getCreateInstructor("Departmental Staff")
  timeslot = TimeSlot.new
  timeslot.days_of_week<< 5
  timeslot.start_time=Time.new.change(hour:10, min:5)
  timeslot.end_time = Time.new.change(hour:11, min:20)
  timeslot.save
  timeslot.sections<< rec

  cs100.save
  cs100.subjects << Subject.find_by_abbr("COMPSCI")
  cs100.save
  cn = cs100.course_numberings.first
  cn.old_number = "100"
  cn.new_number = "201"
  cn.save
  cs100.session = Session.find_by_name("fall2012")
  cs100.save
end

def createcs108
  cs108=Course.new(name:"Software Design and Implementation", 
                   credits:1)
  cs108.description = "Techniques for design and construction of reliable, maintainable and useful software systems. Programming paradigms and tools for medium to large projects: revision control, UNIX tools, performance analysis, GUI, software engineering, testing, documentation."
  cs108.prerequisites<< Course.find_by_name("Data Structures and Algorithms")
  cs108.areas_of_knowledge << AreasOfKnowledge.find_by_abbr("QS")
  cs108.save

  lec = cs108.sections.create!(section_type:"LEC", suffix:"001",
                               location:"Soc Psy 126", enrollment:49,
                               capacity:60, waitlist_enrollment:0, 
                               waitlist_capacity:60,  class_number:1725)
  lec.instructors << getCreateInstructor("Robert Duvall")
  timeslot = TimeSlot.new
  timeslot.days_of_week<< 1
  timeslot.days_of_week << 3
  timeslot.start_time=Time.new.change(hour:13, min:25)
  timeslot.end_time = Time.new.change(hour:14, min:40)
  timeslot.save
  timeslot.sections<< lec

  lec = cs108.sections.create!(section_type:"REC", suffix:"01R",
                               location:"Soc Psy 126", enrollment:49,
                               capacity:60, waitlist_enrollment:0, 
                               waitlist_capacity:60 ,class_number:1726)
  lec.instructors << getCreateInstructor("Robert Duvall")
  timeslot = TimeSlot.new
  timeslot.days_of_week<< 5
  timeslot.start_time=Time.new.change(hour:13, min:25)
  timeslot.end_time = Time.new.change(hour:14, min:40)
  timeslot.save
  timeslot.sections<< lec

  cs108.save
  cs108.session = Session.find_by_name("fall2012")
  cs108.subjects << Subject.find_by_abbr("COMPSCI")
  cs108.save
  cn = cs108.course_numberings.first
  cn.old_number = "108"
  cn.new_number = "308"
  cn.save
  cs108.save
end
