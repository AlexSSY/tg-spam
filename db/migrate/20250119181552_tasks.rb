class Tasks < ActiveRecord::Migration[7.2]
  def change
    create_table :spam do |t|
      t.integer :user_id
      t.integer :message_id
      t.integer :status
      t.timestamps
    end

    create_table :spam_accounts do |t|
      t.integer :spam_id
      t.integer :account_id
    end
  end
end
