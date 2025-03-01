ActiveAdmin.register Appointment do
  permit_params :user_id, :doctor_id, :date, :description
  filter :description, as: :string
  index do
    selectable_column
    id_column
    column "Patient", :user
    column "Doctor", :doctor
    column :date
    column :description 
    actions
  end

  form do |f|
    f.inputs "Appointment Details" do
      f.input :user, as: :select, collection: User.patients
      f.input :doctor, as: :select, collection: User.doctors
      f.input :date, as: :datetime_picker
      f.input :description 
    end
    f.actions
  end
  controller do
    def scoped_collection
      super.page(params[:page]).per(10)
    end
  end
end
