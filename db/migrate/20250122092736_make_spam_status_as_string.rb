class MakeSpamStatusAsString < ActiveRecord::Migration[7.2]
  def change
    change_column :spams, :status, :string, default: "pending"
  end
end
