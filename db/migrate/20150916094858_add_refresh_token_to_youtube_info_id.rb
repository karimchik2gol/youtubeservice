class AddRefreshTokenToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :refresh_token, :string
  end
end
