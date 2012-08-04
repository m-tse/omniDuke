namespace :db do
  desc "Fill database with required course data, i.e. modes of inquiry"	
  task populate: :environment do
    AOKhash = { "NS" => "Natural Sciences", "ALP" => "Arts, Literatures, and Performance", "CZ"=>"Civilizations", "QS"=>"Quantitative Studies", "SS"=>"Social Sciences"}
    AOKhash.each_pair do |k,v|
      if(AreasOfKnowledge.find_by_name(v)==nil)
        AreasOfKnowledge.create!(abbr:k, name:v)
      end
    end

    MOIhash= {"CCI"=> "Cross-Cultural Inquiry", "EI"=>"Ethical Inquiry", "STS"=> "Science, Technology, and Society", "FL"=>"Foreign Language", "R"=>"Research", "W"=> "Writing"}
    MOIhash.each_pair do |k,v|
      if(ModesOfInquiry.find_by_name(v)==nil)
        ModesOfInquiry.create!(abbr:k, name:v)
      end
    end

    SessionsHash = {"spring"=>"2013", "fall"=>"2012", "fall"=>"2013"}
    SessionsHash.each_pair do |k,v|
      if(Session.find_by_name(k+v)==nil)
        Session.create!(season:k, year:v)
      end
    end


  end    
end	  
