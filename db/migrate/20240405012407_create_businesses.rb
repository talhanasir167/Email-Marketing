class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name, null: false, default: ''
      t.string :tag_line, null: false, default: ''
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.timestamps
    end
  end
end
