class AddImageToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :image, :string
  end
end
