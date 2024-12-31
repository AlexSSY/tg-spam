class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.text :session_data

      t.timestamps
    end
  end
end
