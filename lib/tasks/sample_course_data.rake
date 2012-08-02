namespace :db do
  desc "Fill course database with sample data, later on to be retrieved through       web scraping"	
  task populate: :environment do
    subjectsHash = {"COMPSCI"=>"Computer Science", "CLST"=> "Classical Studies",      "CHINESE"=>"Chinese"}
    subjectsHash.each_pair do |k,v|
      if(Subject.find_by_name(v)==nil)
        Subject.create!(abbr:k, name:v)
      end
    end
    createDuvall
    createDepartmentStaff
    createcs100
    createcs108





  end
end

def createDuvall
  Teacher.create!(name:"Robert C. Duvall")
end
def createDepartmentStaff
  Teacher.create!(name:"Departmental Staff")
end

def createcs100
  cs100=Course.new(name:"Data Structures and Algorithms", old_number:100,
                   new_number:201, credits:1, location:"L.S.R.C. B101")
  cs100.teachers<< Teacher.find_by_name("Departmental Staff")
  #add prereqs
  cs100.description="Analysis, use, and design of data structures and algorithms using an object-oriented language like Java to solve computational problems. Emphasis on abstraction including interfaces and abstract data types for lists, trees, sets, tables/maps, and graphs. Implementation and evaluation of programming techniques including recursion. Intuitive and rigorous analysis of algorithms."
  cs100.areas_of_knowledge << AreasOfKnowledge.find_by_abbr("QS")
cs100.session
  cs100.save
end

def createcs108
  cs108=Course.new(name:"Software Design and Implementation", 
                   old_number:108, new_number:308, credits:1, 
                   location:"Soc Psy 126")
  cs108.description="Techniques for design and construction of reliable, maintainable and useful software systems. Programming paradigms and tools for medium to large projects: revision control, UNIX tools, performance analysis, GUI, software engineering, testing, documentation."
  cs108.prerequisites<< Course.find_by_new_number(201)
  cs108.areas_of_knowledge << AreasOfKnowledge.find_by_abbr("QS")
  cs108.save
end
