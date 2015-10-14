class AddToTopicToYslygis < ActiveRecord::Migration
  def change
    add_column :yslygis, :to_topic, :integer
  end
end
