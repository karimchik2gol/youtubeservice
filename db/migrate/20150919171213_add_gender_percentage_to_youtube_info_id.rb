class AddGenderPercentageToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :gender_percentage, :string
  end
end
