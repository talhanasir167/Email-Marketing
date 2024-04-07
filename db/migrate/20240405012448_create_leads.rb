class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.integer :contacts_count, default: 0
      t.references :business, null: false, foreign_key: true
      t.references :business_email, null: false, foreign_key: true

      t.timestamps
    end
  end
end
