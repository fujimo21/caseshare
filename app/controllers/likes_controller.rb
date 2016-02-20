class LikesController < ApplicationController
  
  def index
    @suitcases = current_user.like_suitcases.all
  end  
    
  def create
    @suitcase = Suitcase.find(params[:suitcase_id])
    current_user.like(@suitcase)
  end
  
  def destroy
    @suitcase = current_user.likes.find(params[:id]).suitcase
    current_user.unlike(@suitcase)
  end
  
end