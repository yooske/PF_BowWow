class CreateGroupChats < ActiveRecord::Migration[6.1]
  def change
    create_table :group_chats do |t|
      t.integer :group_id, null: false
      t.integer :end_user_id, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
