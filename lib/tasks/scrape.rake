require_relative "../../util/util"
require 'capybara'
require 'capybara/dsl'



Logging.logger.root.level = :debug
Logging.logger.root.appenders = Logging.appenders.file('scrape-out.log')

$logger = Logging.logger['scrape-logger'] #any name can go in here



namespace :db do
  desc "Scrape data from ACES and enter it into the database"
  task populate: :environment do

    spider = Spider::Google.new
    spider.login()
    spider.search()
  end
end

$wait_time = 10
$username = 'mst17'
$password = ''
#put the path of the elementsIds.temp file here
$projectPath = '/home/ts3m/Development/omniDuke/elementIds.temp'


Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = "http://aces.duke.edu/"
Capybara.default_wait_time = $wait_time
Capybara.automatic_reload = false


module Spider
  class Google
    include Capybara::DSL

    def login()

      visit ('/')
      find_field('j_username')
      fill_in("j_username", :with => $username)
      fill_in('j_password', :with => $password)
      click_button('Enter')

    end


    def search()

      $logger.debug "BEGIN SCRAPING"

      previousLetterId = 0
      previousSubjectId = 0
      previousCourseId = 0
      previousSectionId = 0
 
      if File.exists? $projectPath
        lines = File.open($projectPath).readlines

        previousLetterId = Integer(lines[0].delete("\n"))
        previousSubjectId = Integer(lines[1].delete("\n"))
        previousCourseId = Integer(lines[2].delete("\n"))
        previousSectionId = Integer(lines[3].delete("\n"))
      end
      puts previousLetterId
      puts previousSubjectId
      puts previousCourseId
      puts previousSectionId

      $logger.debug "Previous letter id: #{previousLetterId}"
      $logger.debug "Previous subject id: #{previousSubjectId}"
      $logger.debug "Previous course id: #{previousCourseId}"
      $logger.debug "Previous section id: #{previousSectionId}"


      find_link('Registration').click
      
      alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      letters = Array.new
      alphabet.each_char do |letter|
        letters << letter
      end
      

      #fix this eventually
      currentSession = getCreateSession("fall", 2012)

      ind = true
      begin
        # Loop through A - Z
        letterId = 0
        subjectId = 0
        courseId = 0
        sectionId = 0

        find("iframe#ptifrmtgtframe")
        page.driver.browser.switch_to.frame 'ptifrmtgtframe'
        letters.each do |letter|
          $logger.debug "Starting letter: #{letter}"
          if ind
            if previousLetterId >= letters.length
                $logger.debug "Previous letter id too big, continuing"
                ind = false
                break
            end
            if letterId < previousLetterId
                letterId += 1
                next
            elsif letterId == previousLetterId
                $logger.debug "Current letter id #{letterId} = 
                    previous letter id #{previousLetterId}"
            end
          end
          sleep(1)
          find_link(letter).click   
          sleep(1)
          tries = 0
          begin
              find("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$']")
          rescue
              if tries >= 3
                  $logger.debug "Could not find subjects for letter #{letterId}, skipping this letter"
                  next
              end
              tries += 1
              puts "Trying #{tries}, letter: #{letter}"
              sleep(1)
              retry
          end

          # If it gets to this point then it means that it MUST have subjects
          # so it should NOT run into an infinite loop, hopefully
          subjectElements = page.all("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$']")
          subjectids = Array.new
          for element in subjectElements
            subjectids << element[:id]
          end
          if subjectids.length == 0
            puts "RAISE ERROR: Subject length is 0"
            raise
          end
          puts subjectids.length
          for subjectid in subjectids
            $logger.debug "Starting subject: #{subjectid}"
            if ind
              if previousSubjectId >= subjectids.length
                $logger.debug "Previous section id too big, continuing"
                ind = false
                break
              end
              if subjectId < previousSubjectId
                  subjectId += 1
                  next
              elsif subjectId == previousSubjectId  
                $logger.debug "Current subject id #{subjectId} = 
                    previous subject id #{previousSubjectId}"
              end
            end   

 
            ##set current subject
            subjectNum = subjectid.split('$').last
            subjectAbrvCSSTagger =  createCSSExp("SSR_CLSRCH_SUBJ_SUBJECT$",subjectNum)
            subjectAbrv = find(subjectAbrvCSSTagger).text
            subjectNamesCSSTagger = createCSSExp("SSR_CLSRCH_SUBJ_DESCR$",subjectNum)
            subjectNames = find(subjectNamesCSSTagger).text
            currentSubject = getCreateSubject(subjectNames, subjectAbrv)
            sleep(1)
            click_link(subjectid)

            tries = 0
            begin
                find("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAPS$']")
            rescue
                if tries >= 3
                    click_link(subjectid)
                    $logger.debug "Could not find courses for subject #{subjectId}, skipping"
                    next
                end
                tries += 1
                puts "Trying #{tries}, subject: #{subjectid}"
                sleep(1)
                retry
            end
            
            courseElements = page.all("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAPS$']")
            courseids = Array.new
            for element in courseElements
              courseids << element[:id]
            end
            if courseids.length == 0
              puts "RAISE ERROR: Courses length is 0"
              raise
            end
            for courseid in courseids
              $logger.debug "Starting course: #{courseid}"
              if ind
                if previousCourseId >= courseids.length
                    $logger.debug "Previous course id too big, continuing"
                    ind = false
                    break
                end
                if courseId < previousCourseId
                    courseId += 1
                    next
                elsif courseId == previousCourseId
                  $logger.debug "Current course id #{courseId} = 
                      previous course id #{previousCourseId}"
                end
              end


              courseNUM = courseid.split('$').last

              click_link(courseid)
              sleep(1)

              #set current Course
              course = createCourseInListScreen(courseNUM, currentSubject, currentSession)
              find("a[id^='CLASS_DETAIL$']")
              sectionElements = page.all("a[id^='CLASS_DETAIL$']")
              sectionids = Array.new
              for element in sectionElements
                  sectionids << element[:id]
              end
              if sectionids.length == 0
                  puts "RAISE ERROR: Sections length is 0"
                  raise
              end
              puts sectionids 
              for sectionid in sectionids
                $logger.debug "Current section: #{sectionid}"
                if ind
                  if previousSectionId >= sectionids.length
                      $logger.debug "Previous section id too big, continuing"
                      ind = false
                      break
                  end
                  if sectionId < previousSectionId
                      sectionId += 1
                      next
                  elsif sectionId == previousSectionId
                      $logger.debug "Current section id #{sectionId} = 
                        previous section id #{previousSectionId}"
                      $logger.debug "Indicator turned OFF"
                      ind = false
                  end
                end

                sectionCSSTag = "a[id='"+sectionid+"']"
                find(sectionCSSTag)

                puts letterId
                puts subjectId
                puts courseId
                puts sectionId 

                sectionNum = sectionid.split('$').last
                section = buildSectionInListScreen(course, sectionNum)


                click_link(sectionid)
                page.driver.browser.switch_to.default_content
                page.driver.browser.switch_to.frame 'TargetContent'
                
                section = parseCourseInDetailScreen(section)
                click_link('Return to Search By Subject')

                page.driver.browser.switch_to.default_content
                page.driver.browser.switch_to.frame 'TargetContent'
                sleep(1)
                p section
                course.sections<< section
                section.save
                sectionId += 1
                writeId(section: sectionId)
              end        
              sectionId = 0
              writeId(section: sectionId)
              courseId += 1  
              p course
              writeId(course: courseId)
            end
            courseId = 0
            writeId(course: courseId)
            click_link(subjectid)
            sleep(1)
            subjectId += 1
            writeId(subject: subjectId)
          end
          subjectId = 0
          writeId(subject: subjectId)
          sleep(1)    
          letterId += 1
          puts "OVERWRITING PREVIOUS"
          puts "OVERWRITING PREVIOUS"
          writeId(letter: letterId)
 
        end 

      rescue => e
        $logger.debug "BROKEN"
        $logger.debug "BROKEN"
        $logger.debug "ERROR: #{e.inspect}"
        $logger.debug "BROKEN"
        $logger.debug "BROKEN"
        writeId(letter: letterId, subject: subjectId, course: courseId, section: sectionId)
        raise
      end
    end
  end
  
end


def writeId(options = {letter: nil, subject: nil, course: nil, section: nil})

  previousIds = [0,0,0,0]

  if File.exists? $projectPath
    lines = File.open($projectPath).readlines
    for i in (0..3)
        previousIds[i] = Integer(lines[i].delete("\n"))
    end
  end

  writtenIds = [0,0,0,0]
  keys = [:letter, :subject, :course, :section]
  File.open($projectPath,'w') do |f|
      for i in (0..3)
        value = options[keys[i]]
        if value.nil?
          f.puts previousIds[i]
          writtenIds[i] = previousIds[i]
        else
          f.puts value
          writtenIds[i] = value
        end
      end
  end
 
  p options
  p previousIds

  $logger.debug "Wrote ids to elementsIds.temp
    letter:     #{writtenIds[0]}
    subject:    #{writtenIds[1]}
    course:     #{writtenIds[2]}
    section:    #{writtenIds[3]}
  "

end



def createCSSExp(idstring, number)
  "span[id='"+idstring+number+"']"
end




def parseCourseInDetailScreen(section)
#  begin
    

  section.description = find("span#DERIVED_CLSRCH_DESCRLONG").text
  section.name = find("span#DERIVED_CLSRCH_DESCR200").text
  section.enrollment = find("span#SSR_CLS_DTL_WRK_ENRL_TOT").text.to_i
  section.capacity = find("span#SSR_CLS_DTL_WRK_ENRL_CAP").text.to_i
  section.waitlist_enrollment = find("span#SSR_CLS_DTL_WRK_WAIT_TOT").text.to_i
  section.waitlist_capacity = find("span#SSR_CLS_DTL_WRK_WAIT_CAP").text.to_i
  
  section.career = find("span#PSXLATITEM_XLATLONGNAME").text
  section.grading = find("span#GRADE_BASIS_TBL_DESCRFORMAL").text
  section.location = find("span#CAMPUS_LOC_VW_DESCR").text
  section.campus = find("span#CAMPUS_TBL_DESCR").text
  section.class_number = find("span#SSR_CLS_DTL_WRK_CLASS_NBR").text.to_i
    #fix this eventually?
  section.units = find("span#SSR_CLS_DTL_WRK_UNITS_RANGE").text.to_f
  
  # so it doesn't wait looking for these potentially missing elements
  Capybara.default_wait_time = 0
  topicCSS = "span#CRSE_TOPICS_DESCR"
  if page.has_css?(topicCSS)
    section.topic = find(topicCSS).text
  end
  section.topic ||= "n/a"
  
  enrollmentReqsCSS = "span#SSR_CLS_DTL_WRK_SSR_REQUISITE_LONG"
  if page.has_css?(enrollmentReqsCSS)
    section.enrollment_requirements = find(enrollmentReqsCSS).text
  end
  section.enrollment_requirements ||= "n/a"
  
  # sets wait time back to normal

  
  attrCSS = "span#SSR_CLS_DTL_WRK_SSR_CRSE_ATTR_LONG"
  if page.has_css?(attrCSS)
    attributes = find(attrCSS).text
    attributes.each_line { |l|
      section.course_attributes << getCreateCourseAttribute(l)
    }
  end

  Capybara.default_wait_time = $wait_time
  
  return section
  #  rescue
  #  ensure
  #    section.save
  #    p section
  #  end
end


def createCourseInListScreen(courseNUM, currentSubject, currentSession)



  Capybara.default_wait_time = 0
  oldNumberCSSTag = createCSSExp("DERIVED_SSS_BCC_DESCR$",courseNUM)
  if page.has_css?(oldNumberCSSTag)
    old_number = find(oldNumberCSSTag).text
    old_number = cleanUpOldNumber(old_number)
  end
  old_number ||= 'n/a'


  Capybara.default_wait_time = $wait_time
  newNumberCSSTag = createCSSExp("DU_SS_SUBJ_CAT_CATALOG_NBR$",courseNUM)
  new_number = find(newNumberCSSTag).text

  course = getBuildCourse(currentSubject, currentSession, new_number, old_number)  

  courseCSSTag = createCSSExp("DU_SS_SUBJ_CAT_DESCR$",courseNUM)
  course.name = find(courseCSSTag).text

  course.save
  return course
end


def buildSectionInListScreen(course, sectionNum)
  section = Section.new

  secListNameCSS = createCSSExp("DU_DERIVED_SS_DESCR100$",sectionNum)
  section.list_description = find(secListNameCSS).text
  secRoomCSS = createCSSExp("DERIVED_AA2_REQDESCRB$", sectionNum)
  section.room = find(secRoomCSS).text
  secInstructorCSS = createCSSExp("DU_DERIVED_SS_DESCR100_2$", sectionNum)
  
  timeslotCSS = createCSSExp("DERIVED_AA2_REQDESCRA$", sectionNum)
  timeslottext = find(timeslotCSS).text 
  if timeslottext == " "
    timeslottext = "n/a"
  end
  timeslot = getCreateTimeSlot(timeslottext)
  
  section.time_slot = timeslot
  section.instructors << getCreateInstructor(find(secInstructorCSS).text)

  secReqSectionsCSS = createCSSExp("DU_DERIVED_SS_CRSE_ATTR_VALUE$", sectionNum)
  reqSectionsText = find(secReqSectionsCSS).text
  if reqSectionsText == " "
    reqSectionsText = "n/a"
  end
  section.required_sections = reqSectionsText
  

#  section.save
  return section
end

def cleanUpOldNumber(old_number)
  old_number.split(' ')[1]
end
