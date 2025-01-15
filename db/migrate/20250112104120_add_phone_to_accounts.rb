class AddPhoneToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :phone, :string
  end
end
