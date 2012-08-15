require_relative "../../util/util"

namespace :db do
  desc "Fill course database with sample data, later on to be retrieved through       web scraping, serves as a model for how to fill out the data"	
  task populate: :environment do


    #works!
#    createcs6	
#    createFakeClasses
   # createcs100 broken
   # createcs108 broken
   # createmath103 broken	



  end
end




##Ideal way to write a course to database
def createcs6
  cs6 = Course.create!(name:"INTRO TO COMPUTER SCIENCE")
  
  lec = cs6.sections.create!(list_name:"COMPSCI 101L-001 LEC (1703)", location:"Durham", room:"L.S.R.C. B101", enrollment:226, capacity:240, waitlist_enrollment:4,  waitlist_capacity:200,  class_number:1703, name:"COMPSCI 101L-001 Introduction to Computer Science", description:"Introduction practices and principles of computer science and programming and their impact on and potential to change the world. Algorithmic, problem-solving, and programming techniques in domains such as art, data visualization, mathematics, natural and social sciences. Programming using high-level languages and design techniques emphasizing abstraction, encapsulation, and problem decomposition. Design, implementation, testing, and analysis of algorithms and programs. No previous programming experience required. Instructor: Astrachan, Duvall, Forbes, or Rodger", units:1, career:"Undergraduate", grading:"Graded", campus:"Duke University")

  lec.instructors << getCreateInstructor("Owen Astrachan")
  setSectionTimeSlot(lec, [1,3], "1:25PM", "2:40PM")
  lec.course_attributes << getCreateCourseAttribute("(NS) Natural Sciences")
  lec.save

  csSubject = getCreateSubject("Computer Science", "COMPSCI")
  cs6.subjects << csSubject
 
  cn=cs6.course_numberings.find_by_subject_id(csSubject.id)
  cn.old_number = "6L"
  cn.new_number = "101L"
  cn.save
  cs6.session=getCreateSession("fall", 2012)
  cs6.save
end


def createFakeClasses
  #create subjects
  20.times do |n|
    abbr =  Faker::Lorem.words(1).first+n.to_s
    name = Faker::Lorem.words(1).first+n.to_s

    Subject.create!(abbr:abbr, name:name)
  end

  #createInstructors
  30.times do |n|
    Instructor.create!(name: Faker::Name.name+n.to_s)
  end



  #create courses
  80.times do |n|
    course = Course.create!(name:Faker::Lorem.sentence+n.to_s)
    course.session= getCreateSession("fall", 2012)

    aSubject = Subject.all.sample
    course.subjects<< aSubject
    cn=course.course_numberings.find_by_subject_id(aSubject.id)
    cn.new_number = (rand(1000)+1).to_s+(65+rand(25)).chr
    cn.old_number = (rand(200)+1).to_s+(65+rand(25)).chr
    cn.save
    
    2.times do |i|
      sec = Section.create!
      course.sections << sec
      course.save
      sec.instructors << Instructor.all.sample
      sec.list_name = Faker::Lorem.sentence+n.to_s
      sec.location = "Durham"
      sec.room = Faker::Address.secondary_address
      sec.capacity = rand(250)
      sec.enrollment = rand(sec.capacity)
      sec.waitlist_capacity = rand(100)
      sec.waitlist_enrollment = rand(sec.waitlist_capacity)
      sec.class_number = rand(10000)
      sec.name = Faker::Lorem.sentence+n.to_s
      sec.description = Faker::Lorem.paragraphs(4)
      sec.units = rand(2)+1
      sec.career = "Undergraduate"
      sec.campus = "Duke University"
      sec.grading = "Graded"
      sec.save

    end


  end
  
    







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

  setSectionTimeSlot(lec, [1,3], "10:05AM", "11:20AM")


  rec = cs100.sections.create!(section_type:"REC", suffix:"01R",
                               location:"L.S.R.C. B101", enrollment:123,
                               capacity:180, waitlist_enrollment:0,
                               waitlist_capacity:180, class_number:1715)
  rec.instructors << getCreateInstructor("Departmental Staff")

  setSectionTimeSlot(rec, [5], "10:05AM", "11:20AM")

  cs100.save
  cs100.subjects << getCreateSubject("Computer Science", "COMPSCI")
  cs100.save
  cn = cs100.course_numberings.first
  cn.old_number = "100"
  cn.new_number = "201"
  cn.save
  cs100.session = getCreateSession("fall", 2012)
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

  setSectionTimeSlot(lec, [1,3], "1:25PM", "2:40PM")

  rec = cs108.sections.create!(section_type:"REC", suffix:"01R",
                               location:"Soc Psy 126", enrollment:49,
                               capacity:60, waitlist_enrollment:0, 
                               waitlist_capacity:60 ,class_number:1726)
  rec.instructors << getCreateInstructor("Robert Duvall")

  setSectionTimeSlot(rec, [5], "1:25PM", "2:40PM")

  cs108.save
  cs108.session = getCreateSession("fall", 2012)
  cs108.subjects << getCreateSubject("Computer Science", "COMPSCI")
  cs108.save
  cn = cs108.course_numberings.first
  cn.old_number = "108"
  cn.new_number = "308"
  cn.save
  cs108.save
end

def createmath103
  math103 = Course.new(name:"Multivariable Calculus", credits:1)
  math103.description = "Partial differentiation, multiple integrals, and topics in differential and integral vector calculus, including Green's theorem, the divergence theorem, and Stokes's theorem. Not open to students who have taken Mathematics 202.  Prerequisite: Mathematics 122, 112L, or 122L. Instructor: Staff"
  math103.save
  lec = math103.sections.create!(section_type:"LEC", suffix:"01",
                                 location:"Physics 047", enrollment:31,
                                 capacity:30, waitlist_enrollment:0, 
                                 waitlist_capacity:10, class_number:3424)
  lec.instructors << getCreateInstructor("Xin Zhou")
  setSectionTimeSlot(lec, [2,4], "11:45AM", "1:00PM")
  lec2 = math103.sections.create!(section_type:"LEC", suffix:"02", location:"Physics 235", enrollment:30, capacity:30, waitlist_enrollment:1, waitlist_capacity:30, class_number:3425)
  lec2.instructors << getCreateInstructor("Christopher Cornwell")
  setSectionTimeSlot(lec2, [1,3,5], "12:00PM", "12:50PM")
  math103.areas_of_knowledge << AreasOfKnowledge.find_by_abbr("QS")
  math103.subjects << getCreateSubject("Mathematics", "MATH")
  math103.save
  cn=math103.course_numberings.first
  cn.old_number = "103"
  cn.new_number = "212"
  cn.save
  math103.session = getCreateSession("fall", 2012)
  math103.save

end
