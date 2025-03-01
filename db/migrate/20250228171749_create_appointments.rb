class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :doctor_id
      t.datetime :date

      t.timestamps
    end
  end
end
