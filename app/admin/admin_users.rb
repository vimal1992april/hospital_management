ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index pagination_total: false do  # Disables pagination count query for performance
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password, required: f.object.new_record?, hint: "Leave blank to keep current password"
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.page(params[:page]).per(10)  # Ensures Kaminari pagination is applied
    end
  end
end
