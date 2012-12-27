class Instructor < ActiveRecord::Base
  include ApplicationHelper
  attr_accessible :name
  has_and_belongs_to_many :sections
  has_many :courses, :through => :sections, :uniq => true
  validates :name, presence:true, uniqueness: { case_sensitive: false }

  has_many :instructor_reviews

  before_save :update_overall_rating


  def toString
    self.name
  end

  #has not been tested, waiting on sample data
  #returns an array of this instructor's primary subjects, based on how many courses he's taught in each subject
  def subjects_by_count
    retarray = []
    courseHash = {}
    for course in self.courses
      subject = course.subject
      if courseHash.has_key? subject
        courseHash[subject] = courseHash[subject]+1
      else
        courseHash[subject] = 1
      end
     end
    
    courseHash.sort_by {|k,v| v}
    courseHash.each_key {|key| retarray << key}
    return retarray
  end


  searchable do
    text :name
    text :subjects_by_count_abbr do
      subjects_by_count.map(&:abbr)
    end
    text :subjects_by_count_name do
      subjects_by_count.map(&:name)
    end
  end

  def update_overall_rating
    sum = 0.0
    numReviews = 0.0
    for review in self.instructor_reviews(true)
      numReviews+=1
      reviewCriteria = [review.helpfulness, review.accessibility, review.clarity, review.fairness]
      innerSum = 0.0
      innerCounter = 0.0
      for rating in courseCriteria
        if rating!=nil
          innerSum+=rating 
          innerCounter+=1.0
        end
      end
      if innerCounter == 0.0
        innerCounter+=1.0
      end
      sum+=(innerSum/innerCounter).to_f

    end
    if numReviews ==0.0
      numReviews += 1
    end

    self.overall_quality=(sum/numReviews).to_f
  end



end
