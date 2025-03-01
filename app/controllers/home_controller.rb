class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when "doctor"
      @patients = current_user.patients
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
