class InstructorReview < ActiveRecord::Base
  attr_accessible :author, :review_content, :helpfulness, :accessibility, :clarity, :fairness, :instructor_id
  belongs_to :instructor

  validates :instructor_id, presence:true

  before_save{
    if self.author==nil||self.author==""
      self.author="Anonymous"
    end
    update_average_scores
  }

  after_save{
  	self.instructor.save
  }



  def update_average_scores
    courseQualitySum = 0.0
    courseQualityCounter = 0.0
    courseCriteria = [self.helpfulness, self.accessibility, self.clarity, self.fairness]
    for rating in courseCriteria
      if rating!=nil&&rating!=0
        courseQualityCounter+=1
        courseQualitySum+=rating
      end
    end
    if courseQualityCounter == 0.0
      courseQualityCounter+=1.0
    end
    self.average_quality=(courseQualitySum/courseQualityCounter).to_f
    
  end
end


