class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_message
      t.integer :to_message
      t.string :text
      t.integer :topic_id

      t.timestamps
    end
  end
end
