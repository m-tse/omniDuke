namespace :db do
  desc "Fill database with required course data, i.e. modes of inquiry"	
  task populate: :environment do
    AOKArray  = [ "NS", "ALP", "CZ", "QS", "SS"]
    AOKArray.each do |k|
      if(AreasOfKnowledge.find_by_abbr(k)==nil)
        AreasOfKnowledge.create!(abbr:k)
      end
    end

    MOIarray= ["CCI", "EI", "STS", "FL", "R", "W"]
    MOIarray.each do |k|
      if(ModesOfInquiry.find_by_abbr(k)==nil)
        ModesOfInquiry.create!(abbr:k)
      end
    end



  end    
end	  
