index_block = proc do
  index do
    selectable_column
    id_column
    column :name
    actions
  end
end

filter_block = proc do
  filter :name
end

show_block = proc do
  show do
    attributes_table do
      row :name
      row :created_at
    end
  end
end

form_block = proc do
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end

ActiveAdmin.register Platform do
  permit_params :name
  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&show_block)
  instance_eval(&form_block)
end
