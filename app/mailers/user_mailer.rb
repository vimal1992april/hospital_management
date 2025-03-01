class UserMailer < ApplicationMailer
  default from: 'hospital@example.com'

  # Email when a doctor adds a patient
  def patient_added_email(patient)
    @patient = patient
    @doctor = patient.doctor
    mail(to: @patient.email, subject: "You have been added as a patient by Dr. #{@doctor.name}")
  end

  # Email when a doctor schedules an appointment for a patient
  def appointment_scheduled_email(appointment, patient)
    @appointment = appointment
    @doctor = appointment.doctor
    @patient = patient
    mail(to: @patient.email, subject: "Your appointment with Dr. #{@doctor.name} is scheduled")
  end
end
