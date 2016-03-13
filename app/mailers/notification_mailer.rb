class NotificationMailer < ApplicationMailer
  default from: ENV["SMTP_USER_NAME"]
  
  def reserve(reservation)
    @suitcase = Suitcase.find_by(id: reservation.suitcase_id)
    @owner = @suitcase.user
    @user = User.find_by(id: reservation.user_id)
    @start_date = reservation.start_date.strftime('%Y年%m月%d日')
    @end_date = reservation.end_date.strftime('%Y年%m月%d日')
    @total = reservation.total
    
    mail to: @user.email, subject: "【CaseShared】予約を完了いたしました"
  end
  
  def reserved(reservation)
    @suitcase = Suitcase.find_by(id: reservation.suitcase_id)
    @owner = @suitcase.user
    @user = User.find_by(id: reservation.user_id)
    @start_date = reservation.start_date.strftime('%Y年%m月%d日')
    @end_date = reservation.end_date.strftime('%Y年%m月%d日')
    @total = reservation.total * 0.9
    
    mail to: @owner.email, subject: "【CaseShared】あなたのスーツケースが予約されました"
  end
  
  def reserve_notice(reservation)
    @suitcase = Suitcase.find_by(id: reservation.suitcase_id)
    @owner = @suitcase.user
    @user = User.find_by(id: reservation.user_id)
    @start_date = reservation.start_date.strftime('%Y年%m月%d日')
    @end_date = reservation.end_date.strftime('%Y年%m月%d日')
    @total = reservation.total
    
    mail to: ENV["SMTP_USER_NAME"], subject: "予約成立"
  end
  
end
