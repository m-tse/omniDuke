class CourseReview < ActiveRecord::Base
  attr_accessible :usefulness, :stimulating, :content_quality, :homework_difficulty, 
  :lab_difficulty, :midterm_difficulty, :final_difficulty, :course_meta_id, :out_of_class_work_hours,
  :review_content, :author

  validates :usefulness, :stimulating, :content_quality, :homework_difficulty, 
  :lab_difficulty, :midterm_difficulty, :final_difficulty, :out_of_class_work_hours,
   :inclusion => {:in => [nil,0,1,2,3,4,5,6,7,8,9,10]}

  validates :author, :length => { :maximum => 30 }
  belongs_to :course_meta
  validates :course_meta_id, presence:true

  before_save{
    if self.author==nil||self.author==""
      self.author="Anonymous"
    end
    update_average_scores
  }
  after_save{

  	self.course_meta.save
  }
  def thisReviewAverageQuality
    sum=0.0
    counter=0
    qualityCriteria=[self.stimulating, self.usefulness, self.content_quality]
    for element in qualityCriteria
      if element!=nil&&element!=0
        sum+=element
        counter+=1
      end
    end
    if counter==0
      return 0
    else 
      return (sum/counter).to_f
    end
  end

    def thisReviewAverageDifficulty
    sum=0.0
    counter=0
    difficultyCriteria=[self.midterm_difficulty, self.final_difficulty, 
        self.homework_difficulty, self.lab_difficulty, self.out_of_class_work_hours]
    for element in difficultyCriteria
      if element!=nil&&element!=0
        sum+=element
        counter+=1
      end
    end
    if counter==0
      return 0
    else 
      return (sum/counter).to_f
    end
  end

  def update_average_scores
    courseQualitySum = 0.0
    courseQualityCounter = 0.0
    courseCriteria = [self.stimulating, self.usefulness, self.content_quality]
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


    difficultyCriteria = [self.midterm_difficulty, self.final_difficulty, 
        self.homework_difficulty, self.lab_difficulty, self.out_of_class_work_hours]
    diffSum = 0.0
    diffCounter = 0.0
    for rating in difficultyCriteria
      if rating!=nil&&rating!=0
        diffCounter+=1
        diffSum+=rating
      end
    end
    if diffCounter==0
      diffCounter = 1
    end
    self.average_difficulty=(diffSum/diffCounter).to_f
  end


end
