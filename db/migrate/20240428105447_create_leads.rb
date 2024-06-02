class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.text :bio, default: ''

      t.references :country, null: false, foreign_key: true
      t.references :title, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
