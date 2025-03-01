class Appointment < ApplicationRecord
  belongs_to :user  # Patient
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"

  validates :date, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "user_id", "doctor_id", "date", "description" ,"created_at", "updated_at"]
  end

  # Define searchable associations (if needed)
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
