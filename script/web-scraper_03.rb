#!/usr/bin/env ruby

require 'rubygems'
require 'watir-webdriver'
require 'nokogiri'
require 'mechanize'
require 'open-uri'


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
        browser.text_field(:id, "j_username").set("aks35")
        browser.text_field(:id, "j_password").set("6EF81ba8c2")
        browser.button(:name, "Submit").click
        #browser.wait_until {browser.text.include? "Registration"}
        sleep 5
        browser.link(:text, "Registration").click
        sleep 5
        page_html = Nokogiri::HTML.parse(browser.frame(:name, "TargetContent").html)
        outputHTML('out1.html',page_html)
        f= File.open('out1.html')

        doc = Nokogiri::HTML(f)
#        doc.css("div[@id='popupMaskModal']").each do |node|
#        doc.xpath("//tr/td/div[matches(@id, '^win0divDU_SEARCH_WRK_SSR_EXPAND_COLLAP2\$\d')]").each do |node|
        doc.xpath("//div[substring-before(@id,'$') = 'win0divDU_SEARCH_WRK_SSR_EXPAND_COLLAP2'
                and substring-after(@id, '$') >= 0
                and substring-after(@id, '$') <= 999999]").each do |node|
            puts 'working'
            puts node['id']
        end

        browser.frame(:name, "TargetContent").link(:id, "DU_SEARCH_WRK_SSR_EXPAND_COLLAP2$0").click
        sleep 5
        browser.frame(:name, "TargetContent").link(:id, "DU_SEARCH_WRK_SSR_EXPAND_COLLAPS$0").click
        sleep 5
        page_html = Nokogiri::HTML.parse(browser.html)
        outputHTML('out2.html',page_html)

        browser.frame(:name, "TargetContent").link(:id, "CLASS_DETAIL$0").click
        sleep 5

        #pp page_html
        browser.close
    rescue => e
        puts e.inspect
        puts e.backtrace
        browser.close
    end
end

main()
