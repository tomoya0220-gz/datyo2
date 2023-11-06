class CreateAccountStatuses < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:account_statuses)
      create_table :account_statuses do |t|
        t.string :name, null: false

        t.timestamps
      end
      add_index :account_statuses, :name, unique: true
      execute <<-SQL
        INSERT INTO account_statuses (name, created_at, updated_at) VALUES 
        ('Unverified', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP), 
        ('Verified', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP), 
        ('Closed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      SQL

      create_table :accounts do |t|
        t.references :status, foreign_key: { to_table: :account_statuses }, null: false, default: 1
      end
    end
  end
end
