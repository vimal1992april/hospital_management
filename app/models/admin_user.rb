class AdminUser < ApplicationRecord
  # Devise modules (if applicable)
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable

  # Allowlist attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "created_at", "sign_in_count", "current_sign_in_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
