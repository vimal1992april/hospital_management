ActiveAdmin.register User do
  permit_params :name, :email, :password, :role, :photo, :doctor_id, :blocked
  filter :email
  filter :created_at
  filter :updated_at
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :blocked
    actions
  end
  
  controller do
    def scoped_collection
      super.page(params[:page]).per(10)  # Ensures Kaminari pagination is applied
    end
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :role, as: :select, collection: User.roles.keys
      f.input :photo, as: :file
      f.input :blocked
    end
    f.actions
  end

  member_action :block, method: :put do
    user = User.find(params[:id])
    user.update(blocked: true)
    redirect_to admin_users_path, notice: "User Blocked"
  end

  member_action :unblock, method: :put do
    user = User.find(params[:id])
    user.update(blocked: false)
    redirect_to admin_users_path, notice: "User Unblocked"
  end

  action_item :block, only: :show do
    link_to "Block User", block_admin_user_path(user), method: :put if !user.blocked
  end

  action_item :unblock, only: :show do
    link_to "Unblock User", unblock_admin_user_path(user), method: :put if user.blocked
  end
end
