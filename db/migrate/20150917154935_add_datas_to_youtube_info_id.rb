class AddDatasToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :create_videos, :boolean
    add_column :youtube_info_ids, :making_channel_toghether, :boolean
    add_column :youtube_info_ids, :cross_promotions_and_email_lists, :boolean
    add_column :youtube_info_ids, :recommended_channel_swapping, :boolean
    add_column :youtube_info_ids, :annotation_or_end_card_or_link_swapping, :boolean
    add_column :youtube_info_ids, :open_to_other_types, :boolean
    add_column :youtube_info_ids, :brand_product_integration, :boolean
    add_column :youtube_info_ids, :product_reviews, :boolean
    add_column :youtube_info_ids, :dedicated_videos, :boolean
    add_column :youtube_info_ids, :revenue_affiliate, :boolean
    add_column :youtube_info_ids, :spokesperson, :boolean
    add_column :youtube_info_ids, :offyoutube_promotion, :boolean
    add_column :youtube_info_ids, :including_brand_videos, :boolean
  end
end
