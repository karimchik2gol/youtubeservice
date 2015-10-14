class CreateYslygis < ActiveRecord::Migration
  def change
    create_table :yslygis do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :date

      t.timestamps
    end
  end
end
