class AddDoctorIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :doctor_id, :integer
  end
end
