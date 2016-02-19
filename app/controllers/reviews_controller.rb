class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.create(review_params)
		redirect_to @review.suitcase
	end

	def destroy
		@review = Review.find(params[:id])
		suitcase = @review.suitcase
		@review.destroy

		redirect_to suitcase
	end

	private
		def review_params
			params.require(:review).permit(:comment, :star, :suitcase_id)
		end
end