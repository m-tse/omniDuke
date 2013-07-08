require 'watir-webdriver'
b = Watir::Browser.new :chrome
b.goto 'http://aces.duke.edu/'
# b.text_field()
b.text_field(:id => 'j_username').set 'mst17'
b.text_field(:id => 'j_password').set 'G68x753kav'
b.element(:id => 'Submit').click
b.element(:id => 'div_loading_HC_STUDENT_CENTER_HOME').wait_while_present
b.element(:class => 'ssstabmaintext', :text => 'Registration').when_present.click
# b.select_list(:id => 'entry_1').select 'Ruby'
# b.select_list(:id => 'entry_1').selected? 'Ruby'
# b.button(:name => 'submit').click
# b.text.include? 'Thank you'