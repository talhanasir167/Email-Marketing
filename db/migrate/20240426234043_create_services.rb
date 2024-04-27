class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false, default: ''
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
