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

Capybara.run_server = false
Capybara.current_driver = :selenium
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
 

          find("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$']")


          subjectElements = page.all("a[id^='DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$']")
          subjectids = Array.new
          for element in subjectElements
            subjectids << element[:id]
          end

          for subjectid in subjectids

            ##set current subject
            subjectNum = subjectid.split('').last
            subjectAbbrCSSTagger =  "span[id='"+"SSR_CLSRCH_SUBJ_SUBJECT$"+subjectNum+"']"
            subjectAbbr = find(subjectAbbrCSSTagger).text
            subjectNameCSSTagger = "span[id='"+"SSR_CLSRCH_SUBJ_DESCR$"+subjectNum+"']"
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
              course = Course.new
              courseCSSTag = "span[id='"+"DU_SS_SUBJ_CAT_DESCR$"+courseNUM+"']"
              course.name= find(courseCSSTag).text
              course.subjects << currentSubject
              course.save
              #this needs to be fixed
              cn=course.course_numberings.first
              oldNumberCSSTag = "span[id='"+"DERIVED_SSS_BCC_DESCR$"+courseNUM+"']"
              cn.old_number = find(oldNumberCSSTag).text
              newNumberCSSTag = "span[id='"+"DU_SS_SUBJ_CAT_CATALOG_NBR$"+courseNUM+"']"
              cn.new_number = find(newNumberCSSTag).text
              cn.save
              course.session=currentSession
              course.save

              sectionElements = page.all("a[id^='CLASS_DETAIL$']")
              sectionids = Array.new
              for element in sectionElements
                sectionids << element[:id]
              end
              
              for sectionid in sectionids
                
                click_link(sectionid)
                page.driver.browser.switch_to.default_content
                page.driver.browser.switch_to.frame 'TargetContent'
                

                p find("span#DERIVED_CLSRCH_DESCRLONG").text
                #######################################
                #INSERT PARSING LOGIC HERE #
                ###############################


                click_link('Return to Search By Subject')

                page.driver.browser.switch_to.default_content
                page.driver.browser.switch_to.frame 'TargetContent'
                sleep(5)
              end        
 
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
