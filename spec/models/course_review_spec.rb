require 'spec_helper'

describe CourseReview do
	before do
		@course_meta = FactoryGirl.create(:course_meta)
		@review = CourseReview.new
	end
	subject { @review }
	describe "review should not be valid without course_meta_id." do
		it {should_not be_valid}

		describe "But should be valid after specifying course_meta" do
		before{@review.course_meta_id=@course_meta.id}
		it { should be_valid }

			describe "After saving with blank author, author should save as anonymous" do
				before{@review.save}
				its(:author) {should == "Anonymous"}
			end

			describe "If all fields are blank, it should return average values of 0" do
				before{@review.save}
				its(:average_quality) {should ==0}
				its(:average_difficulty) {should==0}
			end	

			describe "After filling in all course values, it should calculate average quality and difficulty and set them" do
				before do
					@review.usefulness=10
					@review.stimulating=1
					@review.content_quality=7

					@review.homework_difficulty=4
					@review.midterm_difficulty=2
					@review.final_difficulty=5
					@review.lab_difficulty=4
					@review.out_of_class_work_hours=1
					@review.save
				end
				its(:average_quality) {should ==6}
				its(:average_difficulty) {should==3.2}
			end

			describe "When a rating is left nil or set to zero, it should not calculate that in the average" do
				before do
					@review.usefulness=5
					@review.stimulating=0
					@review.content_quality=nil

					@review.lab_difficulty=2
					@review.out_of_class_work_hours=0
					@review.midterm_difficulty=nil
					@review.save
				end
				its(:average_quality) {should == 5}
				its(:average_difficulty) {should==2}
			end


		end


	end


end
