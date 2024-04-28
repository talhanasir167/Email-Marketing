index_block = proc do
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    actions
  end
end

filter_block = proc do
  filter :name
  filter :email
end

scope_block = proc do
  scope 'All Users', :all
  scope 'Admins', :admin
end

show_block = proc do
  show do
    attributes_table do
      row :name
      row :email
      row :role
      row :created_at
    end
  end
end

form_block = proc do
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :role
      f.input :password unless user.persisted?
      f.input :password_confirmation unless user.persisted?
    end
    f.actions
  end
end

ActiveAdmin.register User do
  permit_params :name, :email, :role, :password, :password_confirmation, business_attributes: %i[id name]
  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&scope_block)
  instance_eval(&show_block)
  instance_eval(&form_block)
end
