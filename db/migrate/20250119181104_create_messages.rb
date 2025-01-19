class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :caption

      t.timestamps
    end
  end
end
