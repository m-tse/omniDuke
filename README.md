# What is omniDUKE?

This is a web application built using Ruby on Rails 3.2.7 that aims to be an "omni" data aggregator for Duke University.  It's initial feature will be course data aggregation to replace Duke's horrendous and antiquated ACES system.  It aims to be different from and surpass other sites like Duke Schedulator by providing useful course information in an intelligent manner (Duke Schedulator just schedules courses for you, but if you don't know what course you wish to take, it won't help you in browsing them).

# Setting up test environment

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

# Possible errors

- Failure to build gem native extensio with mysql (2.8.1)

During bundle install, if mysql is not previously installed it will not work. In order to fix this, execute the following commands:

sudo apt-get install libmysqlclient-dev libmysqlclient16
gem install  mysql -v '2.8.1'

Then run bundle install again.


#EC2
to ssh in
ssh -i /microkey.pem ubuntu@DNS.server.com
chmod 400 microkey.pem to fix the permissions on it

#Sunspot
to get the server running 
rake sunspot:solr:start
to reindex
rake sunspot:reindex
turn on sunspot for rspec testing
rake sunspot:solr:start RAILS_ENV=test

#APACHE
to restart,
etc/init.d/apache2 restart
sudo service apache2 restart
apachectl -k graceful-stop

To get rails app running after a clean clone of the repository:
cd to the directory
bundle install
rake db:schema:load
rake sunspot:solr:start
rake db:populate
rails server, see it running at localhost:3000

#Mysql
sudo apt-get install mysql-server mysql-client libmysqlclient-dev (optional to set a password)

remove ‘pg’ and ‘sqlite3’ gems from Gemfile

add ‘mysql’ gem to Gemfile

add/modify the following lines to config/database.yml

development:
  adapter: mysql
  database: db/development
  pool: 5
  username: root
  password:


do this 3 times for development, test, and production, replacing the first and 3rd lines respectively, put a password if you created a password for your mysql server during installation

bundle install
rake db:create:all (creates for dev, test, and production)
rake db:schema:load
rake db:populate
rake sunspot:reindex

you’re done!

to backup and restore mysql databases

to backup, replace db/development with database name, replace xyz with name of backup file
mysqldump --opt --single-transaction --user=root db/development > xyz.sql

to restore, replace db/production with name of destination database, xya with name of backup file
mysql --user=root db/production < xyz.sql

#Documenting getting EC2 up and running
install ruby using RVM!!!!! not regularly not compiling
install all the dependencies using apt-get
install rails via 	gem install rails
install apache2 via	apt-get
install apache2-prefork-dev via 	apt-get
set environmental variables: APXS2, set ruby path
	which apxs2 should work and point to the path, in my case it is /usr/bin/apxs2
	which ruby should work and point to the latest rvm ruby version
	ruby should be in the echo $PATH, in my case
		/home/ts3m/.rvm/gems/ruby-1.9.3-p194/bin
install passenger via 	rvmsudo gem install passenger
install passengermod via 		rvmsudo passenger-install-apache2-module
add the LoadModule passenger_module
	PassengerRoot
	PassengerRuby
stuff to /etc/apache2/apache2.conf at the very bottom

place the following into /etc/apache2/httpd.conf (modify as per your app location)
<VirtualHost *:80>
    ServerName omniduke.local
    DocumentRoot /home/ts3m/Development/omniDuke/public
    <Directory /home/ts3m/Development/omniDuke/public>
         AllowOverride all
        Options -MultiViews
    </Directory>
</VirtualHost>

run apache2 and get bad user name error
to fix:
in /etc/apache2/apache2.conf, change lines 
User ${APACHE....}$
Group ${APACHE_RUN_GROUP}

to 

User www-data
Group www-data


and add the folowing lines to the end of /etc/apache2/envvars

APACHE_RUN_USER=www-data
APACHE_RUN_GROUP=www-data

sudo service apache2 restart 	to restart apache2
rvmsudo passenger-status check if passenger is running

navigate to the DNS URL from your regular computer’s browser, should see passenger phusion screen

run standard database migrations etc. using
RAILS_ENV=production rake db:migrate etc.


#Reference ubuntu rails setup
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl
sudo apt-get install emacs
curl -L https://get.rvm.io | bash -s stable
source /home/ts3m/.rvm/scripts/rvm
sudo apt-get install git
rvm requirements
install them all
rvm install 1.9.3
rvm use 1.9.3
gem install rails
sudo apt-get install libpq-dev
sudo apt-get dist-upgrade
rvm --default use 1.9.3

libmysqlclient-dev

#mysql os x

If you have installed the Startup Item, use this command:

     shell> sudo /Library/StartupItems/MySQLCOM/MySQLCOM start
     (ENTER YOUR PASSWORD, IF NECESSARY)
     (PRESS CONTROL-D OR ENTER "EXIT" TO EXIT THE SHELL)

If you don't use the Startup Item, enter the following command sequence:

     shell> cd /usr/local/mysql
     shell> sudo ./bin/mysqld_safe
     (ENTER YOUR PASSWORD, IF NECESSARY)
     (PRESS CONTROL-Z)
     shell> bg
     (PRESS CONTROL-D OR ENTER "EXIT" TO EXIT THE SHELL)

You should be able to connect to the MySQL server, for example, by
running `/usr/local/mysql/bin/mysql'.

*Note*: The accounts that are listed in the MySQL grant tables
initially have no passwords.  After starting the server, you should set
up passwords for them using the instructions in *Note
post-installation::.

You might want to add aliases to your shell's resource file to make it
easier to access commonly used programs such as `mysql' and
`mysqladmin' from the command line. The syntax for `bash' is:

     alias mysql=/usr/local/mysql/bin/mysql
     alias mysqladmin=/usr/local/mysql/bin/mysqladmin

For `tcsh', use:

     alias mysql /usr/local/mysql/bin/mysql
     alias mysqladmin /usr/local/mysql/bin/mysqladmin

Even better, add `/usr/local/mysql/bin' to your `PATH' environment
variable. You can do this by modifying the appropriate startup file for
your shell. For more information, see *Note invoking-programs::.


