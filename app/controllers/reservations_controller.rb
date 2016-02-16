class ReservationsController < ApplicationController
	before_action :authenticate_user!
	
	def preload
		suitcase = Suitcase.find(params[:suitcase_id])
		today = Date.today
		reservations = suitcase.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations	
	end
	
	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.create(reservation_params)

		redirect_to @reservation.suitcase, notice: "予約されました。"
	end

	private
	
	  def is_conflict(start_date, end_date)
			suitcase = Suitcase.find(params[:suitcase_id])

			check = suitcase.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end
		
		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :price, :total, :suitcase_id)
		end
end