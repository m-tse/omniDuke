class CourseMeta < ActiveRecord::Base
  attr_accessible :course_name
  validates :course_name,  :presence => true

  before_save :update_overall_scores
  has_many :courses
  has_many :course_reviews

  def update_overall_scores
  	overallQualitySum = 0.0
  	difficultySum = 0.0
  	numOverallReviews = 0.0
    numDifficultyReviews = 0.0
  	for review in self.course_reviews(true)

  	  if(review.average_quality>0)
        numOverallReviews+=1
  	  end
  	  overallQualitySum+=review.average_quality

      if(review.average_difficulty>0)
        numDifficultyReviews+=1
  	  end
  	  difficultySum+=review.average_difficulty
  	end
  	if numOverallReviews ==0.0
  	  numOverallReviews=1
  	end
    if numDifficultyReviews ==0.0
      numDifficultyReviews=1
    end

  	self.overall_quality=(overallQualitySum/numOverallReviews).to_f
  	self.overall_difficulty=(difficultySum/numDifficultyReviews).to_f
  end
end
