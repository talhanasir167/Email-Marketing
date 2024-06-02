class CreateProcessedLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :processed_leads do |t|
      t.boolean :active, default: true
      t.string :message_id, null: false, default: ''
      t.string :email_subject, null: false, default: ''

      t.references :lead, null: false, foreign_key: true
      t.references :compaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
