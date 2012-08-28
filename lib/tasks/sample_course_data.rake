require_relative "../../util/util"

namespace :db do
  desc "Fill course database with sample data, later on to be retrieved through       web scraping, serves as a model for how to fill out the data"	
  task populate: :environment do
    require 'factory_girl'
#    createcs6	
#   createFakeClasses

  end
end




##Ideal way to write a course to database
def createcs6
  cs6 = Course.create!(name:"INTRO TO COMPUTER SCIENCE", new_number:"101L", old_number:"6L")
  
  lec = cs6.sections.create!(list_description:"INTRO TO COMPUTER SCIENCE (LEC)", location:"Durham", room:"L.S.R.C. B101", enrollment:226, capacity:240, waitlist_enrollment:4,  waitlist_capacity:200,  class_number:1703, name:"COMPSCI 101L-001 Introduction to Computer Science", description:"Introduction practices and principles of computer science and programming and their impact on and potential to change the world. Algorithmic, problem-solving, and programming techniques in domains such as art, data visualization, mathematics, natural and social sciences. Programming using high-level languages and design techniques emphasizing abstraction, encapsulation, and problem decomposition. Design, implementation, testing, and analysis of algorithms and programs. No previous programming experience required. Instructor: Astrachan, Duvall, Forbes, or Rodger", units:1, career:"Undergraduate", grading:"Graded", campus:"Duke University")
  
  lec.instructors << getCreateInstructor("Owen Astrachan")
  ts = TimeSlot.create!(aces_value:"MW 1:25PM - 2:40PM")
  lec.time_slot = ts
  lec.course_attributes << getCreateCourseAttribute("(NS) Natural Sciences")
  lec.save

  csSubject = getCreateSubject("Computer Science", "COMPSCI")
  cs6.subject = csSubject

  cs6.session=getCreateSession("fall", 2012)
  cs6.save
end


def createFakeClasses
  #create subjects
  50.times do |n|
    FactoryGirl.create(:subject)
  end

  #createInstructors
  50.times do |n|
    FactoryGirl.create(:instructor)
  end

  #createCourseAttributes
  attArray = ["Seminar", "(CCI) Cross Cultural Inquiry", "First Year Students Only", "(SS) Social Sciences", "(ALP) Arts, Literature & Performance", "(CZ) Civilizations", "(NS) Natural Sciences", "(QS) Quantitative Studies", "(EI) Ethical Inquiry", "(STS) Science, Technology, and Society", "(FL) Foreign Language", "(R) Research", "(W) Writing", "Service Learning Course", "Seminar"]
  for att in attArray
    getCreateCourseAttribute(att)
  end

  #createTimeSlots
  TimeSlot.create!(aces_value:"MW 1:25PM - 2:40PM")
  TimeSlot.create!(aces_value:"F 10:05AM - 11:20AM")
  TimeSlot.create!(aces_value:"Th 6:30PM - 8:45PM")
  TimeSlot.create!(aces_value:"M 6:15PM - 7:30PM Th 3:05PM - 5:30PM")
  TimeSlot.create!(aces_value:"TuTh 1:25PM - 2:40PM")
  20.times do |n|
    timeSlotString = ""
    days = ["M","Tu","W","Th","F"]
    ampm = ["AM", "PM"]
    (rand(3)+1).times do |n|
      timeSlotString += days.sample
    end
    timeSlotString += " "+(rand(12)+1).to_s+":"+(rand(60)+1).to_s+ampm.sample
    timeSlotString += " - " +(rand(12)+1).to_s+":"+(rand(60)+1).to_s+ampm.sample
    
  end


  #create courses
  120.times do |n|
    course = FactoryGirl.create(:course)
    course.session= getCreateSession("fall", 2012)

    aSubject = Subject.all.sample

    course.new_number = (rand(1000)+1).to_s+(65+rand(25)).chr
    course.old_number = (rand(200)+1).to_s+(65+rand(25)).chr

    course.subject = aSubject
    course.save
    
    description = Faker::Lorem.paragraphs(5)
    2.times do |i|
      sec = Section.create!
      course.sections << sec
      course.save
      sec.instructors << Instructor.all.sample
      sec.list_description = Faker::Lorem.sentence+n.to_s
      sec.location = "Durham"
      sec.room = Faker::Address.secondary_address
      sec.capacity = rand(250)
      sec.enrollment = rand(sec.capacity)
      sec.waitlist_capacity = rand(100)
      sec.waitlist_enrollment = rand(sec.waitlist_capacity)
      sec.class_number = rand(10000)
      sec.name = Faker::Lorem.sentence+n.to_s
      sec.description = description
      sec.units = rand(2)+1
      sec.career = "Undergraduate"
      sec.campus = "Duke University"
      sec.grading = "Graded"
      sec.time_slot = TimeSlot.all.sample
      rand(5).times do |n|
        sec.course_attributes << CourseAttribute.all.sample
      end

      sec.save

    end


  end
  
    







end





