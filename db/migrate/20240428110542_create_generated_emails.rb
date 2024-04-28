class CreateGeneratedEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :generated_emails do |t|
      t.string :email, null: false, default: ''
      t.string :subject, null: false, default: ''
      t.string :message_id, null: false, default: ''
      t.references :lead, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
