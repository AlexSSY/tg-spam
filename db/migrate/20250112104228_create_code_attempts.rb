class CreateCodeAttempts < ActiveRecord::Migration[7.2]
  def change
    create_table :code_attempts do |t|
      t.integer :user_id
      t.string :code
      t.string :phone
      t.boolean :success

      t.timestamps
    end
  end
end
