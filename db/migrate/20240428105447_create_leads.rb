class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :name, default: ''
      t.string :email, null: false, default: ''
      t.boolean :active, default: true
      t.references :compaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end