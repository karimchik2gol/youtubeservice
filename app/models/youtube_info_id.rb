class YoutubeInfoId < ActiveRecord::Base
  attr_accessible :anketa_id, :average_likes, :image, :average_posted_videos_per_month, :gender, :gender_percentage, :age_gteq, :age_lteq, :average_sharing, :average_views_per_video, :channel_id, :country, :demographic, :description, :name, :published_at, :subscribers, :trailer, :user_id, :video_count, :views, :views_per_month, :refresh_token, :annotation_or_end_card_or_link_swapping, :brand_product_integration, :create_videos, :cross_promotions_and_email_lists, :dedicated_videos, :including_brand_videos, :making_channel_toghether, :offyoutube_promotion, :open_to_other_types, :open_to_other_types_sponsor, :product_reviews, :recommended_channel_swapping, :revenue_affiliate, :spokesperson, :channel_size_limit
  belongs_to :user

  def startYoutubeApi
  	$objectApi=YoutubeApi.new
  	return $objectApi.get_authenticated_services
  end

  def self.execute_info(obj_auth)
    hashData=$objectApi.main(obj_auth)
    unless youtube_info_id=YoutubeInfoId.find_by_channel_id(hashData[:channel_id])
     youtube_info_id=YoutubeInfoId.create(hashData)
     youtube_info_id.save
    else
      youtube_info_id.update_attributes(hashData)
    end
    youtube_info_id
    
  end
end


