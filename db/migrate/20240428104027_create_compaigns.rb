class CreateCompaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :compaigns do |t|
      t.integer :leads_count, default: 0
      t.datetime :scheduled_at, null: false, default: DateTime.now
      t.references :business, null: false, foreign_key: true
      t.references :business_email, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :title, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
