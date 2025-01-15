class CreateCodeRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :code_requests do |t|
      t.integer :user_id
      t.string :phone

      t.timestamps
    end
  end
end
