class CreateTextdescs < ActiveRecord::Migration
  def change
    create_table :textdescs do |t|
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
