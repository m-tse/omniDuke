class CourseMeta < ActiveRecord::Base
  attr_accessible :course_name
  validates :course_name,  :presence => true

  before_save :update_overall_scores
  has_many :courses
  has_many :course_reviews

  def update_overall_scores
  	print "updating"
  	courseSum = 0.0
  	difficultySum = 0.0
  	numReviews = 0
  	for review in self.course_reviews(true)
  	  numReviews+=1
  	  courseCriteria = [review.stimulating, review.usefulness, review.content_quality]
  	  difficultyCriteria = [review.midterm_difficulty, review.final_difficulty, 
  	  	review.homework_difficulty, review.lab_difficulty, review.out_of_class_work_hours]
  	  courseQualitySum = 0
  	  courseQualityCounter = 0
  	  for rating in courseCriteria
  	  	if rating!=nil
  	  	  courseQualityCounter+=1
  	  	  courseQualitySum+=rating
  	  	end
  	  end
  	  if courseQualityCounter == 0
  	  	courseQualitycounter=1
  	  end
  	  courseSum+=(courseQualitySum/courseQualityCounter).to_f

  	  diffSum = 0
  	  diffCounter = 0
  	  for rating in difficultyCriteria
  	  	if rating!=nil
  	  	  diffCounter+=1
  	  	  diffSum+=rating
  	  	end
  	  end
  	  if diffCounter==0
  	  	diffCounter = 1
  	  end
  	  difficultySum+=(diffSum/diffCounter).to_f
  	  p difficultyCriteria
  	  p courseCriteria
  	end

  	if numReviews ==0
  	  numReviews = 1
  	end

  	print "overallquality"+(courseSum/numReviews).to_s
  	p "overalldifficulty"+(difficultySum/numReviews).to_s
  	self.overall_quality=(courseSum/numReviews).to_f
  	self.overall_difficulty=(difficultySum/numReviews).to_f
  end
end
