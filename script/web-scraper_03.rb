#!/usr/bin/env ruby

require 'rubygems'
require 'watir-webdriver'
require 'nokogiri'
require 'mechanize'
require 'open-uri'


require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'


$username = ''
$password = ''

if ARGV.length == 2
    $username = ARGV[0]
    $password = ARGV[1]
end


def outputHTML(filename, page_html)
    File.open(filename,'w') do |f|
        f.puts page_html
    end
end


# Main
def main()
    browser = Watir::Browser.new :ff
    begin
        browser.goto "http://aces.duke.edu/"
        browser.text_field(:id, "j_username").set($username)
        browser.text_field(:id, "j_password").set($password)
        browser.button(:name, "Submit").click
        #browser.wait_until {browser.text.include? "Registration"}
        sleep 5
        browser.link(:text, "Registration").click
        sleep 5
        page_html = Nokogiri::HTML.parse(browser.frame(:name, "TargetContent").html)
        outputHTML('temp.html',page_html)
        f= File.open('temp.html')

        doc = Nokogiri::HTML(f)
#        doc.css("div[@id='popupMaskModal']").each do |node|
#        doc.xpath("//tr/td/div[matches(@id, '^win0divDU_SEARCH_WRK_SSR_EXPAND_COLLAP2\$\d')]").each do |node|
        letters = Array.new
        doc.xpath("//div[starts-with(@id, 'win0divSSR_CLSRCH_WRK2_SSR_ALPHANUM_')]").each           do |node|
            letters << node['id']
        end
    
#        browser.frame(:name, "TargetContent").link(:id, "SSR_CLSRCH_WRK2_SSR_ALPHANUM_B").click

        letters.each do |link|
            link.slice! "win0div"
            puts link
            browser.frame(:name, "TargetContent").link(:id, link).click
            sleep 1
                            
            page_html = Nokogiri::HTML.parse(browser.frame(:name, "TargetContent").html)
            outputHTML('temp.html',page_html)
            f= File.open('temp.html')
            doc = Nokogiri::HTML(f)
            classes = Array.new        
            doc.xpath("//div[substring-before(@id,'$') = 'win0divDU_SEARCH_WRK_SSR_EXPAND_COLLAP2'
                    and substring-after(@id, '$') >= 0
                    and substring-after(@id, '$') <= 999999]").each do |node|
                classes << node['id']
            end
            
            classes.each do |sublink|
                        
                sublink.slice! "win0div"
                puts sublink
    
                browser.frame(:name, "TargetContent").link(:id, sublink).click
                sleep 1
        
                page_html = Nokogiri::HTML.parse(browser.frame(:name, "TargetContent").html)
                outputHTML('temp.html', page_html)
                f = File.open('temp.html')
                doc = Nokogiri::HTML(f)

                courses = Array.new
                doc.xpath("//div[substring-before(@id,'$') = 'win0divDU_SEARCH_WRK_SSR_EXPAND_COLLAPS'
                        and substring-after(@id, '$') >= 0
                        and substring-after(@id, '$') <= 999999]").each do |node|
                    courses << node['id']
                end
                pp courses 
                courses.each do |classlink|
                    classlink.slice! "win0div"
                    browser.frame(:name, "TargetContent").link(:id, classlink).click
                    sleep 1
                    
                    page_html = Nokogiri::HTML.parse(browser.frame(:name, "TargetContent").html)
                    outputHTML('temp.html', page_html)
                    f = File.open('temp.html')
                    doc = Nokogiri::HTML(f)        

                    sections = Array.new
                    doc.xpath("//div[substring-before(@id,'$') = 'win0divCLASS_DETAIL'
                            and substring-after(@id, '$') >= 0
                            and substring-after(@id, '$') <= 999999]").each do |node|
                        sections << node['id']
                    end
            
                    pp sections
                    sections.each do |sectionlink|

                        sectionlink.slice! "win0div"
                        browser.frame(:name, "TargetContent").link(:id, sectionlink).click
                        sleep 2
                    
#                        page_html = Nokogiri::HTML.parse(browser.frame(:name, "TargetContent").html)
#                        outputHTML('temp.html', page_html)
#                        f = File.open('temp.html')
#                        doc = Nokogiri::HTML(f)        
                        
                        browser.frame(:name, "TargetContent").link(:id, "CLASS_SRCH_WRK2_SSR_PB_CLOSE").click
                        sleep 2
            
                        page_html = Nokogiri::HTML.parse(
                            browser.frame(:name, "TargetContent").html)
                        outputHTML('temp.html', page_html)
       #                 exit
                    end

#                    browser.frame(:name, "TargetContent").link(:id, "CLASS_DETAIL$0").click
                    sleep 1
                end                

            end

        end


#        browser.frame(:name, "TargetContent").link(:id, "CLASS_DETAIL$0").click
#        sleep 5

        #pp page_html
        browser.close
    rescue => e
        puts e.inspect
        puts e.backtrace
        browser.close
    end
end

main()
