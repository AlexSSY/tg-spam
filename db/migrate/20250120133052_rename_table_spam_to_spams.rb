class RenameTableSpamToSpams < ActiveRecord::Migration[7.2]
  def change
    rename_table :spam, :spams
  end
end
