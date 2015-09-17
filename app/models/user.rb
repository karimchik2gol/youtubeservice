class User < ActiveRecord::Base
  attr_accessible :anketa_id, :category, :city, :email, :phone, :youtube_info_id
end
