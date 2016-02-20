class PagesController < ApplicationController
  def home
    @suitcases = Suitcase.limit(3)
  end
  
  def search
    
    arrResult = Array.new
    
    @suitcases_active = Suitcase.where(active: true).all
    @search = @suitcases_active.ransack(params[:q])
    @suitcases = @search.result
    
    @arrSuitcases = @suitcases.to_a
      
    if (params[:start_date] && params[:end_date] && !params[:start_date].empty? & !params[:end_date].empty?)

  		start_date = Date.parse(params[:start_date])
  		end_date = Date.parse(params[:end_date])

  		@suitcases.each do |suitcase|

  			not_available = suitcase.reservations.where(
  					"(? <= start_date AND start_date <= ?)
  					OR (? <= end_date AND end_date <= ?) 
  					OR (start_date < ? AND ? < end_date)",
  					start_date, end_date,
  					start_date, end_date,
  					start_date, end_date
  				).limit(1)

  			if not_available.length > 0
  				@arrSuitcases.delete(suitcase)	
  			end	

  		end

  	end
  end
  
  def help
  end
end
