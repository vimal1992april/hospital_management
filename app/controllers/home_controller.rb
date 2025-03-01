class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    per   = params[:limit].nil? ? 10 : params[:limit].to_i
    page  = params[:page].nil? ? 1 : params[:page].to_i
    case current_user.role
    
    when "doctor"
      @patients = User.where(role: "patient", :doctor_id => current_user.try(:id)).paginate(page: page, per_page: per)
      
      @appointments = current_user.appointments.order(date: :desc).limit(5)
    when "patient"
      @appointments = current_user.patient_appointments.order(date: :desc).limit(5)
    when "admin"
      @doctors = User.where(role: :doctor).page(params[:page]).per(10)
      @patients = User.where(role: :patient).page(params[:page]).per(10)
      @appointments = Appointment.order(date: :desc).limit(5)
    end
  end
end
