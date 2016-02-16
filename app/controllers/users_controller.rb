class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@suitcases = @user.suitcases
	end
end