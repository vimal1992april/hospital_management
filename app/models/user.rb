class User < ApplicationRecord
  paginates_per 10  # Optional: Sets default per-page limit
  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "name", "role", "blocked", "created_at", "updated_at"]
  end

  # Allowlist searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["appointments", "doctor", "patients", "photo_attachment", "photo_blob"]
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :appointments, foreign_key: :user_id, dependent: :destroy
  has_many :patients, -> { where(role: 'patient') }, class_name: "User", foreign_key: "doctor_id"
  
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id", optional: true
  
  has_attached_file :photo, styles: { thumb: "100x100>" },
                    url: "/system/:class/:attachment/:id_partition/:style/:filename",
                    path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  validates :email, presence: true, uniqueness: true

  enum role: { admin: 'admin', doctor: 'doctor', patient: 'patient' }
  
  scope :doctors, -> { where(role: 'doctor') }
  scope :patients, -> { where(role: 'patient') }

   # Doctor's Appointments
  has_many :appointments, foreign_key: "doctor_id", dependent: :destroy

  # Patient's Appointments
  has_many :patient_appointments, class_name: "Appointment", foreign_key: "user_id", dependent: :destroy

  def custom_photo_url(style = :original)
    return '' unless photo.exists?

    base_url = Rails.application.routes.default_url_options[:host] || "http://127.0.0.1:3000"

    # Construct the path manually instead of using photo.url(style)
    file_path = "/system/users/photos/#{id.to_s.rjust(9, '0').scan(/\d{3}/).join('/')}/#{style}/#{photo_file_name}"

    "#{base_url}#{file_path}"
  end

end
