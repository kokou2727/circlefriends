class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.text :message, null: false
      t.references :group, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
