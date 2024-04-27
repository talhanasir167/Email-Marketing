# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name,               null: false, default: ''
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.integer  :role, default: 0

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
  end
end

class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name, null: false, default: ''
      t.string :tag_line, null: false, default: ''
      t.string :website_url
      t.references :user, null: false, foreign_key: true
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.timestamps
    end
  end
end

class CreateBusinessEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :business_emails do |t|
      t.string :email, null: false, default: ''
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.integer :contacts_count, default: 0
      t.datetime :scheduled_at, null: false, default: DateTime.now
      t.references :business, null: false, foreign_key: true
      t.references :business_email, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, default: ''
      t.string :email, null: false, default: ''
      t.boolean :active, default: true
      t.references :lead, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateGeneratedEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :generated_emails do |t|
      t.string :email, null: false, default: ''
      t.string :subject, null: false, default: ''
      t.string :message_id, null: false, default: ''
      t.references :contact, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateFollowups < ActiveRecord::Migration[7.0]
  def change
    create_table :followups do |t|
      t.datetime :sent_at, null: false, default: DateTime.now
      t.text :content, null: false, default: ''
      t.boolean :sent, null: false, default: false
      t.references :lead, null: false, foreign_key: true

      t.timestamps
    end
  end
end
