#coding:UTF-8
class Topic < ActiveRecord::Base
  attr_accessible :best, :date_happing, :description, :from_topic, :happing_to, :name, :project_type, :to_topic, :type


  validates :name, :description, :project_type, format:{with: /[[:graph:]]/, message: "Поле заполнено неверно"}
  validate :happing_to, format:{with: /^(начать|закончить)$/, message: "Поле заполнено неверно"}
  validates :date_happing, format:{with: /^([0-9]{2}\/){2}[0-9]{4}$/, message: "Формат: ДД/ММ/ГГГГ"}
end
