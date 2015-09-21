class AddOpenToOtherTypesSponsorToYoutubeInfoId < ActiveRecord::Migration
  def change
    add_column :youtube_info_ids, :open_to_other_types_sponsor, :boolean
  end
end
