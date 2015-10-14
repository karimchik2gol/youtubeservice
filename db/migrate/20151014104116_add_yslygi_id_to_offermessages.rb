class AddYslygiIdToOffermessages < ActiveRecord::Migration
  def change
    add_column :offermessages, :yslygi_id, :integer
  end
end
