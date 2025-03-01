class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_doctor!

  def index
    per   = params[:limit].nil? ? 10 : params[:limit].to_i
    page  = params[:page].nil? ? 1 : params[:page].to_i
    @patients = User.where(role: "patient", :doctor_id => current_user.try(:id)).paginate(page: page, per_page: per)
  end

  def new
    @patient = User.new
  end

  def create
    @patient = current_user.patients.build(patient_params)
    @patient.role = "patient"
    @patient.password = SecureRandom.alphanumeric(10)
    if @patient.save
      UserMailer.patient_added_email(@patient).deliver_now
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
