class User < ActiveRecord::Base
  attr_accessible :anketa_id, :category, :city, :email, :phone, :youtube_info_id, :youtube_info_ids_attributes

  has_many :youtube_info_ids, :dependent=>:destroy
  accepts_nested_attributes_for :youtube_info_ids
end
