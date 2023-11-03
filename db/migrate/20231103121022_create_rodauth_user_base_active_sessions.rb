class CreateRodauthUserBaseActiveSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :status, null: false, default: 1
      t.string :email, null: false
      t.index :email, unique: true
      t.string :password_hash
    end

    # Used by the active sessions feature
    create_table :user_active_session_keys, primary_key: [:user_id, :session_id] do |t|
      t.references :user, foreign_key: true
      t.string :session_id
      t.datetime :created_at, null: false, default: -> { "CURRENT_TIMESTAMP(6)" }
      t.datetime :last_use, null: false, default: -> { "CURRENT_TIMESTAMP(6)" }
    end
  end
end
