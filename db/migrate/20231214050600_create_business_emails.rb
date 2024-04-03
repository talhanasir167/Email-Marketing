class CreateBusinessEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :business_emails do |t|
      t.string :email, null: false, default: ''
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
