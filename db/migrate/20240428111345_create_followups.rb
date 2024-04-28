class CreateFollowups < ActiveRecord::Migration[7.0]
  def change
    create_table :followups do |t|
      t.datetime :sent_at, null: false, default: DateTime.now
      t.text :content, null: false, default: ''
      t.boolean :sent, null: false, default: false
      t.references :compaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
