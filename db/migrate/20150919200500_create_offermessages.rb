class CreateOffermessages < ActiveRecord::Migration
  def change
    create_table :offermessages do |t|
      t.integer :user_id
      t.integer :offer_id
      t.text :text

      t.timestamps
    end
  end
end
