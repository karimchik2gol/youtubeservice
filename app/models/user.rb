#coding:UTF-8
class User < ActiveRecord::Base
  attr_accessible :anketa_id, :category, :city, :email, :phone, :youtube_info_id, :youtube_info_ids_attributes

  validates :youtube_info_id, :presence => true
  validates :email, format:{with: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/, message: "Эмейл введен неверно"}
  validates :category, format:{with: /^(id[0-9],){2,3}$/, message: "Добавьте больше категорий"}
  validates :phone, format:{with: /^[0-9]{7,}$/, message: "Телефон заполнен неверно"}
  validates :city, format:{with: /\D{2,}/, message: "Введите город"}

  has_many :youtube_info_ids, :dependent=>:destroy
end
