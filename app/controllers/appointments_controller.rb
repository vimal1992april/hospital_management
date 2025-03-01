class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_doctor!

  def new
    @patient = current_user.patients.find(params[:patient_id])
    @appointment = Appointment.new
  end

  def create
    @patient = current_user.patients.find(params[:patient_id])
    @appointment = @patient.patient_appointments.build(appointment_params)
    @appointment.doctor = current_user

    if @appointment.save
      redirect_to patient_path(@patient), notice: "Appointment added successfully."
    else
      render :new
    end
  end

  def destroy
    @appointment = current_user.appointments.find(params[:id])
    @appointment.destroy
    redirect_to patient_path(@appointment.patient), notice: "Appointment canceled."
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :description)
  end

  def check_doctor!
    redirect_to root_path, alert: "Access denied!" unless current_user.doctor?
  end
end
