class AddChannelSizeLimitToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :channel_size_limit, :boolean
  end
end
