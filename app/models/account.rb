class Account < ActiveRecord::Base
  include Rodauth::Rails.model
  enum status: { unverified: 1, verified: 2, closed: 3 }

    # パスワードハッシュを設定
  account = Account.create!(email: "user@example.com", password: "secret123")
  account.password_hash #=> "$2a$12$k/Ub1I2iomi84RacqY89Hu4.M0vK7klRnRtzorDyvOkVI.hKhkNw."

  # パスワードハッシュをクリアする
  account.password = nil
  account.password_hash #=> nil

  # 関連付け
  account.remember_key #=> #<Account::RememberKey> (record from `account_remember_keys` table)
  account.active_session_keys #=> [#<Account::ActiveSessionKey>,...] (records from `account_active_session_keys` table)
end
