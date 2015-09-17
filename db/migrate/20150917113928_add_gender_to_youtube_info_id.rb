class AddGenderToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :gender, :string
  end
end
