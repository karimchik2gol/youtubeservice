class User < ActiveRecord::Base
  attr_accessible :anketa_id, :category, :city, :email, :phone, :youtube_info_id, :youtube_info_ids_attributes

  validate :category, :email, :phone, :youtube_info_id, :category, :presence => true
  validate :email, format:{with: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/, message: "invalid email"}
  validate :category, format:{with: /^([0-9],){2,3}$/, message: "invalid category"}
  validate :phone, format:{with: /^[0-9]{7,}$/, message: "invalid phone"}
  validate :city, format:{with: /\D{2,}/, message: "invalid city"}

  has_many :youtube_info_ids, :dependent=>:destroy
  accepts_nested_attributes_for :youtube_info_ids
end
