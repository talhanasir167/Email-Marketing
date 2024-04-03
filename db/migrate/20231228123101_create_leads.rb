class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.integer :count, default: 0
      t.integer :followup_count, default: 0
      t.datetime :first_followup, null: false, default: ''
      t.datetime :second_followup, null: false, default: ''
      t.datetime :third_followup, null: false, default: ''
      t.datetime :fourth_followup, null: false, default: ''
      t.references :business, null: false, foreign_key: true
      t.references :business_email, null: false, foreign_key: true

      t.timestamps
    end
  end
end
