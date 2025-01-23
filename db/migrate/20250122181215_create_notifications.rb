class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :text
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
