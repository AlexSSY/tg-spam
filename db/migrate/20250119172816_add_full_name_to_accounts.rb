class AddFullNameToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :full_name, :string
  end
end
