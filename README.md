# README for omniDUKE

This is a web application built using Ruby on Rails 3.2.7 that aims to be an "omni" data aggregator for Duke University.  It's initial feature will be course data aggregation to replace Duke's horrendous and antiquated ACES system.  It aims to be different from and surpass other sites like Duke Schedulator by providing useful course information in an intelligent manner (Duke Schedulator just schedules courses for you, but if you don't know what course you wish to take, it won't help you in browsing them).

In order to get it working

- have the following installed: ruby 1.9.3, rails 3.2.7, git, ruby-gems, Java JDK7
- clone the repository via git clone http://github.com/tS3m/omniDuke
- navigate to the omniDuke directory
- run the following commands:

- bundle install
- rake db:schema:load
- bundle exec rake sunspot:solr:start
- rake db:populate
- rake sunspot:reindex
- rails s

- navigate to http://localhost:3000 to see the app running