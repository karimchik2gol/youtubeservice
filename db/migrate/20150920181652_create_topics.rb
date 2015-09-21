class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :to_topic
      t.integer :from_topic
      t.string :name
      t.string :type
      t.string :project_type
      t.string :happing_to
      t.string :date_happing
      t.text :description
      t.string :best

      t.timestamps
    end
  end
end
