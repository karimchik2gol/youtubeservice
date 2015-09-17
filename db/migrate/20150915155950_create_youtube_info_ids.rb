class CreateYoutubeInfoIds < ActiveRecord::Migration
  def change
    create_table :youtube_info_ids do |t|
      t.integer :user_id
      t.integer :anketa_id
      t.string :name
      t.text :description
      t.string :trailer
      t.integer :video_count
      t.datetime :published_at
      t.string :channel_id
      t.text :demographic
      t.integer :views_per_month
      t.integer :views
      t.float :average_views_per_video
      t.float :average_sharing
      t.float :average_likes
      t.float :average_posted_videos_per_month
      t.text :country
      t.integer :subscribers

      t.timestamps
    end
  end
end
