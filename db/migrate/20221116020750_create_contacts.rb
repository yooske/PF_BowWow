class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :end_user_id
      t.integer :category
      t.text :body
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
