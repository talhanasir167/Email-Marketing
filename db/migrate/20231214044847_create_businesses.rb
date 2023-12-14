class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name, null: false, default: ''
      t.text :description, null: false, default: ''

      t.timestamps
    end
  end
end
