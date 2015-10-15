class AddObmenLikeToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :obmen_like, :boolean
    add_column :youtube_info_ids, :obmen_like_yslyga, :boolean
    add_column :youtube_info_ids, :reklama_v_rolike, :boolean
    add_column :youtube_info_ids, :reklama_v_rolike_yslyga, :boolean
  end
end
