namespace :db do
  desc "Fill database with required course data, i.e. modes of inquiry"	
  task populate: :environment do
    AOKhash = { "NS" => "Natural Sciences", "ALP" => "Arts, Literatures, and Performance", "CZ"=>"Civilizations", "QS"=>"Quantitative Studies", "SS"=>"Social Sciences"}
    AOKhash.each_pair do |k,v|
      if(AreasOfKnowledge.find_by_name(v)==nil)
        AreasOfKnowledge.create!(abbr:k, name:v)
      end
    end

    MOIarray= ["CCI", "EI", "STS", "FL", "R", "W"]
    MOIarray.each do |k|
      if(ModesOfInquiry.find_by_abbr(k)==nil)
        ModesOfInquiry.create!(abbr:k)
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
