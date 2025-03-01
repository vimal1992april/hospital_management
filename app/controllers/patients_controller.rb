class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_doctor!

  def index
    
    @patients = current_user.patients.reorder(nil).page(params[:page]).per(10)

  end

  def new
    @patient = User.new
  end

  def create
    @patient = current_user.patients.build(patient_params)
    @patient.role = "patient"

    if @patient.save
      redirect_to patients_path, notice: "Patient added successfully."
    else
      render :new
    end
  end

  def show
    @patient = current_user.patients.find(params[:id])
    @appointments = @patient.patient_appointments.order(date: :desc)
  end

  private

  def patient_params
    params.require(:user).permit(:name, :email, :photo)
  end

  def check_doctor!
    redirect_to root_path, alert: "Access denied!" unless current_user.doctor?
  end
end
