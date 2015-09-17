class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.string :category
      t.string :city
      t.integer :youtube_info_id
      t.integer :anketa_id

      t.timestamps
    end
  end
end
