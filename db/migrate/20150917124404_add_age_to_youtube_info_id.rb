class AddAgeToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :age_gteq, :integer
    add_column :youtube_info_ids, :age_lteq, :integer
  end
end
