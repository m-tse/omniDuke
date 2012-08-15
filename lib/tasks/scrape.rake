require_relative "../../util/util"
require 'capybara'
require 'capybara/dsl'



namespace :db do
  desc "Scrape data from ACES and enter it into the database"
  task populate: :environment do

#    spider = Spider::Google.new
#    spider.search
  end
end

#Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.app_host = "http://aces.duke.edu/"
Capybara.default_wait_time = 60



$username = ''
$password = ''




module Spider
  class Google
    include Capybara::DSL
    
    def search()
      

      visit ('/')
      find_field('j_username')
      fill_in("j_username", :with => $username)
      fill_in('j_password', :with => $password)
      click_button('Enter')

      find_link('Registration').click
      
      alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      letters = Array.new
      alphabet.each_char do |letter|
        letters << letter
      end
      

      #fix this eventually
      currentSession = getCreateSession("fall", 2012)


      # Loop through A - Z
      letters.each do |letter|
        
        
        find("iframe#ptifrmtgtframe")
        page.driver.browser.switch_to.frame 'ptifrmtgtframe'
        sleep(2)
        find_link(letter).click   
        sleep(1)

          find("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$']")


          subjectElements = page.all("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$']")
          subjectids = Array.new
          for element in subjectElements
            subjectids << element[:id]
          end

          for subjectid in subjectids

            ##set current subject
            subjectNum = subjectid.split('').last
            subjectAbbrCSSTagger =  createCSSExp("SSR_CLSRCH_SUBJ_SUBJECT$",subjectNum)
            subjectAbbr = find(subjectAbbrCSSTagger).text
            subjectNameCSSTagger = createCSSExp("SSR_CLSRCH_SUBJ_DESCR$",subjectNum)
            subjectName = find(subjectNameCSSTagger).text
            currentSubject = getCreateSubject(subjectName, subjectAbbr)



            sleep(1)
            click_link(subjectid)


            find("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAPS$']")
   
            courseElements = page.all("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAPS$']")
            courseids = Array.new
            for element in courseElements
              courseids << element[:id]
            end
            
            for courseid in courseids
              courseNUM = courseid.split('').last
              click_link(courseid)
              sleep(2)

              #set current Course
              course = createCourseInListScreen(courseNUM, currentSubject)

              course.session=currentSession
              course.save

              sectionElements = page.all("a[id^='CLASS_DETAIL$']")
              sectionids = Array.new
              for element in sectionElements
                sectionids << element[:id]
              end
              
              for sectionid in sectionids
                sectionNum = sectionid.split('').last
                
                section = createSectionInListScreen(course, sectionNum)


                click_link(sectionid)
                page.driver.browser.switch_to.default_content
                page.driver.browser.switch_to.frame 'TargetContent'
                


                parseCourseInDetailScreen(section)
                


                click_link('Return to Search By Subject')

                page.driver.browser.switch_to.default_content
                page.driver.browser.switch_to.frame 'TargetContent'
                sleep(5)
              end        
              p course
            end
            click_link(subjectid)
            sleep(2)
          end
          sleep(2)    

      end 
      sleep(9000)
    end
  end
  
end



def createCSSExp(idstring, number)
  "span[id='"+idstring+number+"']"
end




def parseCourseInDetailScreen(section)
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

  attributes = find("span#SSR_CLS_DTL_WRK_SSR_CRSE_ATTR_LONG").text
  attributes.each_line { |l|
    section.course_attributes << getCreateCourseAttribute(l)
  }


  section.save
  p section
end


def createCourseInListScreen(courseNUM, currentSubject)
  course = Course.create!
  courseCSSTag = createCSSExp("DU_SS_SUBJ_CAT_DESCR$",courseNUM)
  course.name= find(courseCSSTag).text
  course.subjects << currentSubject
  cn=course.course_numberings.find_by_subject_id(currentSubject.id)
  oldNumberCSSTag = createCSSExp("DERIVED_SSS_BCC_DESCR$",courseNUM)
  cn.old_number = find(oldNumberCSSTag).text
  newNumberCSSTag = createCSSExp("DU_SS_SUBJ_CAT_CATALOG_NBR$",courseNUM)
  cn.new_number = find(newNumberCSSTag).text
  cn.save
  
  course.save
  return course
end


def createSectionInListScreen(course, sectionNum)
  section = Section.create!

  secListNameCSS = createCSSExp("DU_DERIVED_SS_DESCR100$",sectionNum)
  section.list_name = find(secListNameCSS).text
  secRoomCSS = createCSSExp("DERIVED_AA2_REQDESCRB$", sectionNum)
  section.room = find(secRoomCSS).text
  secInstructorCSS = createCSSExp("DU_DERIVED_SS_DESCR100_2$", sectionNum)
  
  timeslotCSS = createCSSExp("DERIVED_AA2_REQDESCRA$", sectionNum)
  timeslot = getCreateTimeSlot(find(timeslotCSS).text)
  section.time_slot = timeslot
  section.instructors << getCreateInstructor(find(secInstructorCSS).text)
  section.save
  course.sections<< section
  return section
end
