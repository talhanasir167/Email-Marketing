class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.references :business, null: false, foreign_key: true
      t.datetime :first_followup, null: false, default: ''
      t.datetime :second_followup, null: false, default: ''
      t.datetime :third_followup, null: false, default: ''
      t.datetime :fourth_followup, null: false, default: ''

      t.timestamps
    end
  end
end
