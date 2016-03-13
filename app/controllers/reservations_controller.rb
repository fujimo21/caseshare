class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]
	
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

		if @reservation
			# send request to PayPal
			values = {
				business: 'y.fujomoto-facilitator@gmail.com',
				#business: 'y.fujomoto@gmail.com',
				cmd: '_xclick',
				upload: 1,
				#notify_url: 'https://web-service-fujimo21.c9users.io/notify',
				notify_url: 'http://caseshare.herokuapp.com/notify',
				amount: @reservation.total,
				currency_code: 'JPY',
				item_name: @reservation.id,
				item_number: @reservation.id,
				quantity: '1',
				#return: 'https://web-service-fujimo21.c9users.io/your_trips'
				return: 'http://caseshare.herokuapp.com/your_trips'
			}

			redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
			#redirect_to "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
			
		else
			redirect_to @reservation.suitcase, alert: "何か問題が発生しました。"
		end 
	end
	
	protect_from_forgery except: [:notify]
	def notify
		params.permit!
		status = params[:payment_status]

		reservation = Reservation.find(params[:item_number])

		if status == "Completed"
			
			if status != true
				NotificationMailer.reserve(reservation).deliver_now
				NotificationMailer.reserved(reservation).deliver_now
				NotificationMailer.reserve_notice(reservation).deliver_now
			end
			
			reservation.update_attributes status: true
			
		else
			reservation.destroy
		end

		render nothing: true
	end
	
	protect_from_forgery except: [:your_trips]
	def your_trips
	  @trips = current_user.reservations.where("status = ?", true)
	end
	
	def your_reservations
	  @suitcases = current_user.suitcases
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