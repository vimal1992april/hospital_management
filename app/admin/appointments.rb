ActiveAdmin.register Appointment do
  permit_params :user_id, :doctor_id, :date

  index do
    selectable_column
    id_column
    column "Patient", :user
    column "Doctor", :doctor
    column :date
    actions
  end

  form do |f|
    f.inputs "Appointment Details" do
      f.input :user, as: :select, collection: User.patients
      f.input :doctor, as: :select, collection: User.doctors
      f.input :date, as: :datetime_picker
    end
    f.actions
  end
  controller do
    def scoped_collection
      super.page(params[:page]).per(10)
    end
  end
end
