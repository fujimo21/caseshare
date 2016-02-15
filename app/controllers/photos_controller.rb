class PhotosController < ApplicationController

	def destroy
		@photo = Photo.find(params[:id])
		suitcase = @photo.suitcase

		@photo.destroy
		@photos = Photo.where(suitcase_id: suitcase.id)

		respond_to :js
	end
end