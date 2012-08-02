namespace :db do
  desc "Fill course database with sample data, later on to be retrieved through web scraping"	
  task populate: :environment do
    subjectsHash = {"COMPSCI"=>"Computer Science", "CLST"=> "Classical Studies", "CHINESE"=>"Chinese"}
    subjectsHash.each_pair do |k,v|
      if(Subject.find_by_name(v)==nil)
        Subject.create!(abbr:k, name:v)
      end
    end
  end
end
