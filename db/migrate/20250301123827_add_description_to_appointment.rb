class AddDescriptionToAppointment < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :description, :text
  end
end
