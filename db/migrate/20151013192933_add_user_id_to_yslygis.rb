class AddUserIdToYslygis < ActiveRecord::Migration
  def change
    add_column :yslygis, :user_id, :integer
  end
end
